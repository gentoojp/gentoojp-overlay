# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

MY_P=${P/_beta/b-}

DESCRIPTION="A.I. Soft's famous Japanese input method"
HOMEPAGE="http://www.ekotoba.com/"
SRC_URI=""
#SRC_URI="http://www.elec.ryukoku.ac.jp/~fujii/pub/ftp/ime/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND="app-i18n/canna"

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${MY_P}.tar.gz

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	einfo "Nothing to compile."
}

src_install() {

	dodir /usr/sbin
	dodir /usr/bin
	dodir /var/lib
	dodir /usr/share/doc/${PF}
	dodir /usr/share/doc/${PF}/sample
	dodir /usr/share/doc/${PF}/html

	make linux -s \
		DESTDIR=${D} \
		SBINDIR=/usr/sbin \
		BINDIR=/usr/bin \
		LIBDIR=/var/lib \
		DOCDIR=/usr/share/doc/${PF} \
		RCDIR=/usr/share/doc/${PF}/sample \
		HTMLDIR=/usr/share/doc/${PF}/html \
		RCFILE=wxg \
		WXG=wxg.linux.tar.gz || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/wxg.sh wxg || die

	dodoc README
}

pkg_postinst() {

	einfo
	einfo "WXG configuration file resides in /var/lib/wxg/wxgrc."
	einfo "Please stop cannaserver before you start wxgserver."
	einfo
}
