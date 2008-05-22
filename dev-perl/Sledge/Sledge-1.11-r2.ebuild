# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module eutils

DESCRIPTION="Sledge - Opensource Web Application Framework - for apache2"
SRC_URI="mirror://sourceforge.jp/sledge/8401/${P}.tar.gz"
HOMEPAGE="http://sl.edge.jp/"

SLOT="0"
LICENSE="Artistic | GPL-2"
SRC_TEST="do"
KEYWORDS="~~x86"
IUSE=""

DEPEND="dev-perl/libapreq2
        dev-perl/Apache-Reload
        >=dev-perl/CGI-2.47
        dev-perl/Test-Inline
        dev-perl/Carp-Assert
        dev-perl/Class-Fields
        dev-perl/Class-Accessor
        dev-perl/Class-Data-Inheritable
        dev-perl/Class-Singleton
        dev-perl/Class-Trigger
        dev-perl/Digest-SHA1
        dev-perl/File-Spec
        dev-perl/File-Temp
        dev-perl/HTML-FillInForm
        dev-perl/HTML-Template
        dev-perl/HTML-StickyQuery
        dev-perl/IO-stringy
        dev-perl/Jcode
        dev-perl/libwww-perl
        dev-perl/Test-Simple
        dev-perl/Test-Harness
        dev-perl/Time-HiRes
        dev-perl/URI
        dev-perl/Errno
        dev-perl/Template-Toolkit
        dev-perl/Data-Properties
        >=dev-perl/Error-0.15
        dev-perl/Storable
        dev-perl/Encode-compat"

src_unpack() {
        unpack ${A}
        epatch ${FILESDIR}/Apache.patch
}
