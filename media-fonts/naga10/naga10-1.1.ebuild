# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="knj10-${PV}"

DESCRIPTION="Naga10 - Japanese 10 dot font suitable for small screen"
HOMEPAGE="http://hp.vector.co.jp/authors/VA013391/fonts/"
SRC_URI="http://hp.vector.co.jp/authors/VA013391/fonts/${MY_P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack ${A}

	cd "${S}"
	patch -o maru10.bdf < maru10.bdf.diff || die
	patch -o min10.bdf < min10.bdf.diff || die
}

src_compile() {

	for bdffile in *.bdf
	do
		(bdftopcf ${bdffile} | gzip > ${bdffile%.bdf}.pcf.gz) || die
	done
}

src_install () {

	local FONTPATH="/usr/share/fonts/naga10"

	insopts -m0644
	insinto ${FONTPATH}
	doins *.pcf.gz || die

	dodoc README INSTALL
}
