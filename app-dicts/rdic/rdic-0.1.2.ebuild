# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

DESCRIPTION="EIJIRO dictionary search tool written in Ruby"
HOMEPAGE="http://www.yasgursfarm.us/rdic/"
SRC_URI="http://www.yasgursfarm.us/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=dev-lang/ruby-1.6.8
	>=dev-ruby/ruby-mmap-0.2.2"

S=${WORKDIR}/${P}

src_compile() {

	ruby extconf.rb || die
	make || die
}

src_install() {

	einstall DESTDIR=${D} || die

	keepdir /usr/share/dicts/EIJIRO

	exeinto /usr/bin
	doexe rdic
	
	cnv2*

	dodoc ChangeLog* README* xselection.rd*
	dohtml xselection.html{,.ja}
}

pkg_postinst() {

	einfo
	einfo "Place your EIJIRO dictionary files (e.g. EIJIRO65.TXT, OTOJIRO.TXT,"
	einfo "REIJI65.TXT, RYAKU65.TXT and WAEIJI65.TXT) to /usr/share/dicts/EIJIRO/"
	einfo "and run"
	einfo "\tebuild /var/db/pkg/app-dicts/rdic/${PF}.ebuild config"
	einfo "to convert EIJIRO dictionary files into ALC format."
	einfo 
}

pkg_config() {

	for x in /usr/share/dicts/EIJIRO/*TXT ; do
		ruby -Ke conv2alc.rb 
	done
}
