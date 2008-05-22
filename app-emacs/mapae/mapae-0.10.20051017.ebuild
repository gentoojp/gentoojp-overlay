# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit elisp eutils

DESCRIPTION="mapae is front end of Movable Type"
HOMEPAGE="http://nyam.info/diary/archives/20031130061500.html"
SRC_FILENAME="mapae-`echo ${PV} | sed -e "s/\./-/g" `"
SRC_URI="http://nyam.info/files/mapae/${SRC_FILENAME}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/emacs"

S="${WORKDIR}/${SRC_FILENAME}"
SITEFILE="65mapae-gentoo.el"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	elisp-comp *.el
}

src_install () {

	elisp-install ${PN} *.el*

    # install mapae.pl
	insinto /usr/share/emacs/site-lisp/mapae
	insopts -m0755
	doins mapae.pl

    # install document
	dodoc Version
	dohtml mapae.html

    # install extra files
	insinto /usr/share/doc/${PF}
	insopts -m644
    doins  mapae.ph extlib preview_template.html

	# install GENE configuration emacs lisp
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die	
}

pkg_postinst () {
	ewarn "please copy mapae.ph to ~/.mapae and set opition instead of mapae.ph"
}