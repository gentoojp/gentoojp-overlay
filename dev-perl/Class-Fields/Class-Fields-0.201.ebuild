# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

MY_P=Class-Fields-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Class::Fields - Inspect the fields of a class."
SRC_URI="http://cpan.org/modules/by-authors/id/M/MS/MSCHWERN/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mschwern/${MY_P}/lib/Class/Fields.pm"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

newdepend "dev-perl/Carp-Assert
           >=dev-perl/base-2.00"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
