# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Sledge::Plugin::SessionAutoCleanup."
HOMEPAGE="http://sl.edge.jp/download.html"
SRC_URI="mirror://sourceforge.jp/sledge/2365/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"

DEPEND="dev-perl/Sledge"

SRC_TEST="do"
