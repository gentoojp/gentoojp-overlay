# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="HTML::FillInForm - Populates HTML Forms with CGI data."
SRC_URI="http://cpan.org/modules/by-module/HTML/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
SRC_TEST="do"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=">=dev-perl/HTML-Parser-3.26"

