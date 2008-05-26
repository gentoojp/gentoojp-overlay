# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

MY_P=Data-Properties-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Data::Properties - persistent properties"
SRC_URI="http://cpan.org/modules/by-authors/id/I/IX/IX/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ix/${MY_P}/Properties.pm"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
