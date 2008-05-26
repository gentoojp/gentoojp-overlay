# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Photo Image Print System for Linux. EPSON PM-G700 Linux driver."
HOMEPAGE="http://www.avasys.jp/linux/index.html"
SRC_URI="http://lx2.avasys.jp/pips/pmg700/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 EAPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="cups lprng"

DEPEND="sys-libs/lib-compat
	<x11-libs/gtk+-2.0.0
	cups? ( >net-print/cups-1.1.14 )
	!cups? ( >=app-text/ghostscript-5.50
		app-text/psutils
		lprng? (net-print/lprng) )"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-bugs.patch
	use !cups && epatch ${FILESDIR}/${P}-lpr.patch
}

src_compile() {
	./configure || die "configure failed"
	make || die "make failed"
}

src_install() {
	if ! $(grep 35586/tcp /etc/services > /dev/null 2>&1) ; then
		cp /etc/services ${T}/services
		cat >>${T}/services<<-EOF
		cbtd		35586/tcp		# pipsg700 ekpd
		EOF

		insinto /etc
		doins ${T}/services
	fi
	use lprng && if ! $(grep pmg700 /etc/lprng/printcap >/dev/null 2>&1) ; then
		cp /etc/lprng/printcap ${T}/printcap
		cat >>${T}/printcap <<-EOF
		pmg700|EPSON PM-G700 printer entry
			:lp=/var/ekpd/ekplp0
			:sh
			:if=/usr/local/EPKowa/PMG700/filterg700
			:sd=/var/spool/lpd/pmg700
			:mx#0
		EOF

		insinto /etc/lprng
		doins ${T}/printcap

	fi

	make DESTDIR=${D} install

	cd ${S}
	dodoc COPYING COPYING.KOWA COPYING.KOWA.ja COPYING.LIB

	use lprng && chmod 777 ${D}/var/ekpd
	use lprng && chmod 660 ${D}/var/ekpd/ekplp0
	use lprng && chown root:lp ${D}/var/ekpd/ekplp0
	use lprng && diropts -m 700 -o lp -g lp
	use lprng && dodir /var/spool/lpd/pmg700

	exeinto /etc/init.d
	newexe ${FILESDIR}/ekpd.initd ekpd
}

pkg_config() {
	use cups && lpadmin -p pmg700 -E -v ekplp:/var/ekpd/ekplp0 -m ekpmg700.ppd
	use cups && lpoptions -p pmg700 -o media=A4_AUTO
}

pkg_postinst() {
	einfo
	einfo "1. Start ekpd."
	einfo "       /etc/init.d/ekpd start & rc-update add ekpd default"
	use cups && einfo "2. Restart CUPS(cupsd)."
	use cups && einfo "       /etc/init.d/cupsd restart"
	use cups && einfo "3. Add printer & Set paper-size."
	use cups && einfo "       \"ebuild /var/db/pkg/net-print/${PF}/${PF}.ebuild config\""
	use lprng && einfo "2. Restart LPRng(lpd)."
	use lprng && einfo "      /etc/init.d/lprng restart"
	einfo
}