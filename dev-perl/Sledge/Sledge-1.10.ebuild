# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

MY_P=Sledge-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Sledge - Opensource Web Application Framework"
SRC_URI="http://sl.edge.jp/redir?to=http://downloads.sourceforge.jp/sledge/2353/${MY_P}.tar.gz"
HOMEPAGE="http://sl.edge.jp/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86"

newdepend "dev-perl/libapreq
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
           dev-perl/Storable"

src_compile() {
        perl-module_src_compile
        perl-module_src_test || die "test failed"
}
