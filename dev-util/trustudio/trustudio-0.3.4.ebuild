# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="TruStudio is an IDE built on top of Eclipse Platform."

CORE="mirror://sourceforge/trustudio/xws-core-${PV}.zip"
DOC="mirror://sourceforge/trustudio/xws-php_manual-${PV}.zip"
DOC_JP="mirror://sourceforge/trustudio/xws-php_manual-${PV}-ja.zip"
DOCUMENTOR="mirror://sourceforge/trustudio/xws-php_documentor-${PV}.zip"

HOMEPAGE="http://www.eclipse.org/"
SRC_URI="${CORE}
	${DOC}
	${DOCUMENTOR}
	nls?( ${DOC_JP})"
RESTRICT="nomirror"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="=dev-util/eclipse-platform-bin-2.1*"
S="${WORKDIR}/${P}"

src_compile() {
	return
}

src_install() {
	dodir /opt/eclipse/plugins
	dodir /opt/eclipse/features
	
	cp -dpR	plugins/com.xored.*  ${D}/opt/eclipse/plugins/
	cp -dpR	features/com.xored.* ${D}/opt/eclipse/features/
}
