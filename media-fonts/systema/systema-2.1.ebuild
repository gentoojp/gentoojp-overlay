# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="An artistic Gothic font made from M+ and Konatu fonts"
HOMEPAGE="http://uk.geocities.com/systema81/"
SRC_URI="http://uk.geocities.com/systema81/${PN}-rel21.zip"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONT_S="${S}"
