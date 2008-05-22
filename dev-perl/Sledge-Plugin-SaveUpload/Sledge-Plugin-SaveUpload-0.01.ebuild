# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="Sledge::Plugin::SaveUpload."
SRC_URI="mirror://sourceforge.jp/sledge/2431/${P}.tar.gz"
HOMEPAGE="http://sl.edge.jp/download.html"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="GPL-2 | Artistic"

SRC_TEST="do"

DEPEND="${DEPEND}"
