# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="HTTP::MobileAgent - HTTP mobile user agent string parser."
SRC_URI="http://cpan.org/modules/by-module/HTTP/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/HTTP/${P}.readme"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="${DEPEND}"
