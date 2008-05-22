# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit perl-module

DESCRIPTION="Sledge::Plugin::Mailer."
SRC_URI="http://www.godtomato.net/works/download/lib/perl/Sledge/Sledge-Plugin-Mailer/${P}.tar.gz"
HOMEPAGE="http://www.godtomato.net/works/download/lib/perl/Sledge/Sledge-Plugin-Mailer/"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="dev-perl/Email-Valid
        dev-perl/Sledge"
