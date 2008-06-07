# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module eutils

DESCRIPTION="Sledge - Opensource Web Application Framework"
HOMEPAGE="http://sl.edge.jp/"
SRC_URI="mirror://sourceforge.jp/sledge/8401/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="apache2"

DEPEND="|| (
		apache2? ( >=www-apache/libapreq2-2.06 )
		>=www-apache/libapreq-1.3
	)
	dev-perl/Apache-Reload
	>=perl-core/CGI-2.47
	dev-perl/Test-Inline
	dev-perl/Carp-Assert
	dev-perl/Class-Fields
	dev-perl/Class-Accessor
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Singleton
	dev-perl/Class-Trigger
	dev-perl/Digest-SHA1
	perl-core/File-Spec
	perl-core/File-Temp
	dev-perl/HTML-FillInForm
	dev-perl/HTML-Template
	dev-perl/HTML-StickyQuery
	dev-perl/IO-stringy
	dev-perl/Jcode
	dev-perl/libwww-perl
	perl-core/Test-Simple
	perl-core/Test-Harness
	perl-core/Time-HiRes
	dev-perl/URI
	dev-perl/Errno
	dev-perl/Template-Toolkit
	dev-perl/Data-Properties
	>=dev-perl/Error-0.15
	perl-core/Storable
	dev-perl/Encode-compat"

SRC_TEST="do"

src_unpack() {
	unpack ${A}
	use apache2 && epatch "${FILESDIR}/${P}-mod_perl2.patch" || die
}
