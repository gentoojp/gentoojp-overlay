# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="pdumpfs cleaner"
HOMEPAGE="http://tach.arege.net/software/pdumpfs-clean/"
SRC_URI="http://tach.arege.net/software/pdumpfs-clean/pdumpfs-clean"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/ruby"

src_install() {
	dobin "${DISTDIR}"/pdumpfs-clean || die
}
