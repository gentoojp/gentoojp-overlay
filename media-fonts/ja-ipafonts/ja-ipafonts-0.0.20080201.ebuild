# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

MY_P="IPAfont00203"

DESCRIPTION="Japanese TrueType fonts developed by IPA (Information-technology Promotion Agency, Japan)"
HOMEPAGE="http://ossipedia.ipa.go.jp/ipafont/"
SRC_URI="http://ossipedia.ipa.go.jp/ipafont/${MY_P}.php/${MY_P}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~x86 ~x86-fbsd"
IUSE=""

DEPEND="${DEPEND}
	app-arch/unzip"

RESTRICT="mirror strip binchecks"

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}/${MY_P}"
DOCS="Readme*.txt"
