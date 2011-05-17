# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="EIJIRO dictionary search tool written in Ruby"
HOMEPAGE="http://www.yasgursfarm.us/rdic/"
SRC_URI="http://www.yasgursfarm.us/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND+=" dev-ruby/mmap"
DEPEND="${RDEPEND}"

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf failed"
}

each_ruby_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	keepdir /usr/share/dicts/EIJIRO

	exeinto /usr/bin
	doexe rdic

	insinto /usr/share/rdic
	doins cnv2*

	dodoc ChangeLog* README* xselection.rd*
	dohtml xselection.html{,.ja}
}

pkg_postinst() {
	elog ""
	elog "Place your EIJIRO dictionary files (e.g. EIJIRO65.TXT, OTOJIRO.TXT,"
	elog "REIJI65.TXT, RYAKU65.TXT and WAEIJI65.TXT) to /usr/share/dicts/EIJIRO/"
	elog "and run"
	elog "\tebuild /var/db/pkg/app-dicts/rdic/${PF}.ebuild config"
	elog "to convert EIJIRO dictionary files into PDIC format."
	elog ""
}

pkg_config() {
	einfo ""
	einfo "Now convert EIJIRO dictionary files to PDIC format."
	einfo "It takes time for a while."
	einfo ""

	for x in /usr/share/dicts/EIJIRO/*TXT ; do
		ruby -Ke /usr/share/rdic/cnv2rdic.rb $x | sort -k1,1 -t: -f > ${x%.TXT}.euc
	done
}
