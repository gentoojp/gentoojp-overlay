# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils subversion

DESCRIPTION="Python Desktop Server"
HOMEPAGE="http://pyds.muensterland.org/"

ESVN_REPO_URI="http://simon.bofh.ms/pyds/trunk"

KEYWORDS="~x86"
SLOT="0"
LICENSE="MIT"
IUSE=""

RDEPEND="media-libs/jpeg
	sys-libs/zlib
	>=dev-lang/python-2.2.2
	>=dev-python/medusa-0.5.4
	>=dev-db/metakit-2.4.9.2
	>=dev-python/cheetah-0.9.15
	>=dev-python/pyxml-0.8.2
	>=dev-python/pyrex-0.5
	>=dev-python/docutils-0.3
	>=dev-python/imaging-1.1.4
	>=dev-python/soappy-0.11.1
	>=app-text/silvercity-0.9.5"

DOCS="INSTALL-FROM-SOURCE INSTALL-SILVERCITY-ON-JAGUAR INSTALL-WAD-FOR-PYDS OVERVIEW"
