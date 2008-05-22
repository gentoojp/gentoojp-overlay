# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

At="j2sdk-1_4_0-doc-ja.zip"
S="${WORKDIR}/docs"
SRC_URI="j2sdk-1_4_0-doc-ja.zip"
DESCRIPTION="Javadoc Japanese for Java SDK version 1.4.0"
HOMEPAGE="http://java.sun.com/j2se/1.4.2/ja/download.html"
LICENSE="sun-j2sl"
SLOT="1.4.0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc -alpha -mips -hppa ~ppc64"
IUSE=""
DEPEND=">=app-arch/unzip-5.50-r1"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and move it to ${DISTDIR}"
}

src_unpack() {
	unpack ${At} || die "Failed Unpacking"
}

src_install(){
	dohtml ja/index.html

	local dirs="ja/api ja/guide ja/images ja/relnotes ja/tooldocs"

	for i in $dirs ; do
		cp -a $i ${D}/usr/share/doc/${P}/html
	done
}
