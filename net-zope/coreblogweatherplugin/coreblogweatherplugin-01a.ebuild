# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit zproduct

DESCRIPTION="Zope product for COREBlog plugin to display weather report"

DEPEND=">=net-zope/zweatherapplet-1.51
        >=net-zope/coreblog-073b"

HOMEPAGE="http://bakauke.ddo.jp/"
SRC_URI="http://bakauke.ddo.jp/files/COREBlogWeatherPlugin01a.tgz"
LICENSE="as-is"
KEYWORDS="~x86"

ZPROD_LIST="COREBlogWeatherPlugin"


