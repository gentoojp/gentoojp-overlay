# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Email::Valid::Loose - Email::Valid which allows dot before at mark"
HOMEPAGE="http://cpan.org/modules/by-authors/id/M/MI/MIYAGAWA/"
SRC_URI="http://cpan.org/modules/by-authors/id/M/MI/MIYAGAWA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/Email::Valid"

SRC_TEST="do"
