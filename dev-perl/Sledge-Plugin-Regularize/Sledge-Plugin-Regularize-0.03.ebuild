# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="Sledge::Plugin::Regularize."
SRC_URI="http://www.godtomato.net/lib/Sledge/Sledge-Plugin-Regularize/${P}.tar.gz"
HOMEPAGE="http://www.godtomato.net/lib/Sledge/Sledge-Plugin-Regularize/"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="dev-perl/Sledge
        dev-perl/Lingua-JA-Regular"
