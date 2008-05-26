# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

DESCRIPTION="JIS fontmetric files for pTeX/dvips"

HOMEPAGE="http://www.ascii.co.jp/pb/ptex/base/sources.html"
SRC_URI="ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex/jvf/jis.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="<=app-text/ptex-3.1.8.1"

S=${WORKDIR}/jis

src_install() {

	insinto ${TEXMF}/fonts/tfm/ptex
	doins tfm/ptex/*.tfm

	insinto ${TEXMF}/fonts/vf/ptex
	doins vf/*.vf

	dodoc README.txt
}