# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$


MY_P="elisat10.tar.gz"
S=${WORKDIR}
DESCRIPTION="ELISA 8x8 Japanese font"
SRC_URI="http://www.bsdbbq.org/~toshi/distfiles/${MY_P}"
HOMEPAGE="http://hp.vector.co.jp/authors/VA002310/"
SLOT=0
KEYWORDS="~x86"
LICENSE="freeware"

DEPEND=""
RDEPEND=$DEPEND

PREFIX="/usr/share/fonts/ja/elisa/"


src_unpack() {
	unpack ${MY_P}
	cd "${S}"
	bdftopcf elisat10.bdf   | gzip > elisat10.pcf.gz
	bdftopcf jpnhn4-iso.bdf | gzip > jpnhn4-iso.pcf.gz
	bdftopcf jpnhn4-jis.bdf | gzip > jpnhn4-jis.pcf.gz
}

src_install() {
	# install fonts
	insinto ${PREFIX}
	doins *.pcf.gz
	doins fonts.alias
	newins "${FILESDIR}"/fonts.dir.elisa fonts.dir

	dodoc elisa100.doc elisat10.doc elisat10.html
}

pkg_postinst() {
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	echo -e "\n\t FontPath \"${PREFIX}\"\n\n"
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	echo -e "\n\t FontPath \"${PREFIX}\"\n\n"
}
