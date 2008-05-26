# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="UNIVERSAL::exports - Lightweight, universal exporting of variables."
SRC_URI="http://cpan.org/modules/by-authors/id/M/MS/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/M/MS/MSCHWERN/${P}.readme"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="dev-perl/Exporter-Lite"
