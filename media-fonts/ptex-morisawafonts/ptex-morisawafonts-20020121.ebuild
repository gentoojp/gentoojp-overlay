# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/media-fonts/ptex-jisfonts/ptex-jisfonts-20020520.ebuild,v 1.1 2004/07/17 13:58:11 okayama Exp $

DESCRIPTION="JIS fontmetric files for pTeX/dvips"

HOMEPAGE="http://www.ascii.co.jp/pb/ptex/base/sources.html"

SRC_URI="ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex/jvf/morisawa.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~x86"

DEPEND="<=app-text/ptex-3.1.8.1"

S=${WORKDIR}/morisawa

src_install() {

	insinto /usr/share/texmf/fonts/tfm/ptex
	doins tfm/ptex/*.tfm

	insinto /usr/share/texmf/fonts/vf/ptex
	doins vf/*.vf

	dodoc README.txt
}

pkg_postinst() {

	mktexlsr
}

pkg_postrm() {

	mktexlsr
}
