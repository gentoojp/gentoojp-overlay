# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="An artistic Gothic font made from M+ and Konatsu fonts"
HOMEPAGE="http://uk.geocities.com/systema81/"
SRC_URI="http://uk.geocities.com/systema81/current.zip"

LICENSE="CCPL-Attribution-NonCommercial-ShareAlike"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONT_S="${S}"
