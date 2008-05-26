# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="Sledge::Plugin::SubmitBack."
SRC_URI="http://www.godtomato.net/lib/Sledge/Sledge-Plugin-SubmitBack/${P}.tar.gz"
HOMEPAGE="http://www.godtomato.net/lib/Sledge/Sledge-Plugin-SubmitBack/"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="Artistic || GPL-2"

SRC_TEST="do"

DEPEND="dev-perl/Sledge"
