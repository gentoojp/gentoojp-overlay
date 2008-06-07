# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="HTML::Entities::ImodePictogram - encode / decode i-mode pictogram."
HOMEPAGE="http://cpan.org/modules/by-module/HTML/"
SRC_URI="http://cpan.org/modules/by-module/HTML/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"

DEPEND="dev-perl/HTTP-MobileAgent"

SRC_TEST="do"
