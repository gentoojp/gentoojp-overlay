# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit font

DESCRIPTION="Hacked version of IPA fonts, which is suitable for browsing 2ch"
HOMEPAGE="http://www.geocities.jp/ipa_mona/index.html"
MY_P="${PN}${PV}"
SRC_URI="http://www.geocities.jp/ipa_mona/openprinting-jp-0.1.3_${MY_P}.tar.gz"
LICENSE="grass-ipafonts"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~ppc-macos ~ppc64 ~amd64"
IUSE=""

S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONT_S="${S}/openprinting-jp-0.1.3/ipafont"
