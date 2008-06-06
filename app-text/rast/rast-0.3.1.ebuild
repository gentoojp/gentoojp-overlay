# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Rast is a full-text search system."
HOMEPAGE="http://projects.netlab.jp/rast/"
SRC_URI="http://projects.netlab.jp/rast/archives/${P}.tar.bz2"
<<<<<<< HEAD:app-text/rast/rast-0.3.1.ebuild
LICENSE="GPL-2"
=======
>>>>>>> e7c37620830f642fe5ddbd3553da8739bde358d0:app-text/rast/rast-0.1.1.ebuild

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="mecab unicode ruby"

DEPEND=">=dev-libs/apr-0.9.5
	>=sys-libs/db-4.2.52
	mecab? ( app-text/mecab )
	unicode? ( >=dev-libs/icu-2.8 )
	ruby? ( >=dev-lang/ruby-1.8.1 )"

src_install() {
<<<<<<< HEAD:app-text/rast/rast-0.3.1.ebuild
	make DESTDIR="${D}" install || die
=======
	make DESTDIR="${D}" install || die "make install failed"
>>>>>>> e7c37620830f642fe5ddbd3553da8739bde358d0:app-text/rast/rast-0.1.1.ebuild
}
