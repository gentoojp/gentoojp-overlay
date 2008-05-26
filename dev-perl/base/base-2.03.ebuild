# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

MY_P=base-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="base - Establish IS-A relationship with base class at compile time"
SRC_URI="http://cpan.org/modules/by-authors/id/M/MS/MSCHWERN/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mschwern/${MY_P}/lib/base.pm"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
