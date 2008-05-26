# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit zproduct

DESCRIPTION="Zope product for COREBlog plugin to display times"

DEPEND=">=net-zope/coreblog-0.73b
       >=dev-python/Imaging-py21-1.1.4"

HOMEPAGE="http://coreblog.org/"
SRC_URI="http://coreblog.org/junk/BlogTimesPlugin${PV}.tgz"
LICENSE="as-is"
KEYWORDS="~x86"

ZPROD_LIST="BlogTimesPlugin"
