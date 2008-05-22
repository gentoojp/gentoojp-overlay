# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

PYTHON_SLOT_VERSION=2.1

inherit distutils

P_NEW="${PN%-py21}-${PV/_pre/pre}"

S=${WORKDIR}/${P_NEW}
DESCRIPTION="Python Japanese Character filter"
SRC_URI="http://www.gembook.jp/html/download/${P_NEW}.tgz"
HOMEPAGE="http://www.gembook.jp/tsum/page.pys?wiki=PyKf"

SLOT="0"
LICENSE=""
KEYWORDS="~x86"

DEPEND="dev-python/japanesecodecs-py21"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins readme.sjis
	insinto /usr/share/doc/${PF}/test
	doins test/*
	insinto /usr/share/doc/${PF}/misc
	doins misc/*.txt
}
