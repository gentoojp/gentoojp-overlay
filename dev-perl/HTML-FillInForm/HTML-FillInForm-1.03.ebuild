# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

MY_P=HTML-FillInForm-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="HTML::FillInForm - Populates HTML Forms with CGI data."
SRC_URI="http://cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

newdepend ">=dev-perl/HTML-Parser-3.26"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
