# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

MY_P=HTML-StickyQuery-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="HTML::StickyQuery - add sticky QUERY_STRING"
SRC_URI="http://cpan.org/modules/by-authors/id/I/IK/IKEBE/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/I/IK/IKEBE/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

newdepend ">=dev-perl/URI-1.00
           >=dev-perl/HTML-Parser-3.00"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
