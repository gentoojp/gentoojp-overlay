# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="Sledge-Dispacher."
SRC_URI="mirror://sourceforge.jp/sledge/16499/${P}.tar.gz"
HOMEPAGE="http://sl.edge.jp/download.html"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="dev-perl/Sledge"
