# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/_p/-d}

DESCRIPTION="an encoding detection library for Japanese, Chinese, Korean and Thai languages"
HOMEPAGE="http://www.honeyplanet.jp/download.html"
SRC_URI="http://www.honeyplanet.jp/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

src_install() {
	dodir /usr/lib /usr/include
	make install PREFIX="${D}/usr" || die "make install failed"
}
