# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-pkg subversion

ESVN_REPO_URI="http://svn.apache.org/repos/asf/jakarta/commons/sandbox/i18n/trunk/"
MY_PN="commons-i18n"

DESCRIPTION="This package adds the feature of localized message bundles that group localized messages together"
HOMEPAGE="http://jakarta.apache.org/commons/sandbox/i18n/"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	=dev-java/avalon-logkit-1.2*
	dev-java/log4j"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_unpack() {
	subversion_src_unpack || die "unpack failed"
	cd "${S}"
	echo "version=${PV}" >> build.properties
	echo "build.lib=./lib" >> build.properties
}

src_compile() {
	local antflags="build"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} jar || die "compile problem"
}

src_install() {
	java-pkg_newjar lib/${MY_PN}-${PV}.jar ${MY_PN}.jar

	use doc && java-pkg_dohtml -r doc/javadoc/
	use source && java-pkg_dosrc src/java/*
}
