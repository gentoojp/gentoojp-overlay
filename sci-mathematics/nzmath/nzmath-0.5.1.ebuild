# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

inherit distutils

DESCRIPTION="number theory oriented calculation system built on Python"
HOMEPAGE="http://tnt.math.metro-u.ac.jp/nzmath/"

MY_P=${P/nzmath/NZMATH}
SRC_URI="http://tnt.math.metro-u.ac.jp/nzmath/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=dev-lang/python-2.3"

DOCS="CHANGES.txt HISTORY.txt LICENSE.txt tutorial.txt"
