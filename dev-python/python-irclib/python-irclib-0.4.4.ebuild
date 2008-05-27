# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

IUSE=""

DESCRIPTION="An event-driven IRC client framework written in Python"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://python-irclib.sourceforge.net/"
RESTRICT="nomirror"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND="dev-lang/python"
