# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Class::Fields - Inspect the fields of a class."
SRC_URI="http://cpan.org/modules/by-module/Class/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Class/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
SRC_TEST="do"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="dev-perl/Carp-Assert"

