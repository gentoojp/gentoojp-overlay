# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog2/coreblog2-0.8b.ebuild,v 1.2 2005/10/18 02:30:52 dang Exp $

inherit zproduct

NEW_PV="${PV//./-}"

DESCRIPTION="Blog/Weblog/Web Nikki system for Zope/Plone."
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog2_08b.tgz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ZPROD_LIST="COREBlog2"
