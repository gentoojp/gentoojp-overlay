# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

NEW_PV="${PV//./-}"

DESCRIPTION="Blog/Weblog/Web Nikki system for Zope/Plone."
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog2_081a.tgz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ZPROD_LIST="COREBlog2"
