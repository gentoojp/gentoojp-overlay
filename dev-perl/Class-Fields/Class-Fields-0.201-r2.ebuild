# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Class::Fields - Inspect the fields of a class."
HOMEPAGE="http://cpan.org/modules/by-module/Class/"
SRC_URI="http://cpan.org/modules/by-module/Class/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="dev-perl/Carp-Assert
        >=dev-perl/base-2.00"

