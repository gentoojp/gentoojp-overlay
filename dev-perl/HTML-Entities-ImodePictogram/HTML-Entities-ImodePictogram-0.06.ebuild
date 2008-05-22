# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="HTML::Entities::ImodePictogram - encode / decode i-mode pictogram."
SRC_URI="http://cpan.org/modules/by-module/HTML/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="dev-perl/HTTP-MobileAgent"
