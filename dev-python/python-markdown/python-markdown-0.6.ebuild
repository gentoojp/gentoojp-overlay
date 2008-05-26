# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""
DESCRIPTION="Python markdown implementation."
SRC_URI="http://www.freewisdom.org/projects/python-markdown/markdown.py http://www.freewisdom.org/projects/python-markdown/setup.py"
HOMEPAGE="http://www.freewisdom.org/projects/python-markdown"

DEPEND="virtual/python"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
    echo ${A}
    for file in ${A}
    do
	cp ${DISTDIR}/${file} ${WORKDIR}
    done
}

src_install() {
    cd ${WORKDIR}
    python setup.py install --root=${D} || die
}


