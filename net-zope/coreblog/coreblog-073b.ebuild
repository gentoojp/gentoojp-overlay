# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="Zope product for Blog/Weblog/Web Nikki system"

HOMEPAGE="http://coreblog.org/"
SRC_URI="http://coreblog.org/junk/COREBlog${PV}.tgz"
LICENSE="as-is"
KEYWORDS="~x86"

ZPROD_LIST="COREBlog"

pkg_postinst()
{
	zproduct_pkg_postinst
	einfo "---> NOTE: Remember to check Add COREBlog Comments for anonymous setting in security tab."
	einfo "---> NOTE: After that, please add some category, so you can begin to add entries. Also please fill up some fields on setting tab."
}
