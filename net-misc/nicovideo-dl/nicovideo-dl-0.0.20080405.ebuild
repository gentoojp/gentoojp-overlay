# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A small command-line program to download videos from nicovideo.jp."
HOMEPAGE="http://sourceforge.jp/projects/nicovideo-dl/"
SRC_URI="mirror://sourceforge.jp/${PN}/30371/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN}
}
