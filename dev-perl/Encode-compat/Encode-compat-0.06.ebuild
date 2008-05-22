# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Class::Accessor - Automated accessor generation"
SRC_URI="http://cpan.org/modules/by-authors/id/A/AU/AUTRIJUS/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/A/AU/AUTRIJUS/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
