# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit webapp

DESCRIPTION="Simple feture-rich wiki variant"
# currently unavailable due to domain expiration
# HOMEPAGE="http://en.pukiwiki.org/"
# HOMEPAGE="http://221.245.246.245/"
HOMEPAGE="http://sourceforge.jp/projects/pukiwiki/"
MY_P=${P/5.1/5_1_notb}
SRC_URI="http://osdn.dl.sourceforge.jp/pukiwiki/12962/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="${PVR}"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/httpd-php"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	gunzip *.gz
	tar zxf wiki.en.tgz
	rm wiki.en.tgz
}

src_install() {
	webapp_src_preinst
	cat ${FILESDIR}/en.txt >> README.en.txt
	webapp_postinst_txt en README.en.txt
	local docs=`echo COPYING.* README.* UPDATING.*`
	local doc
	for doc in ${docs}; do
		dodoc $doc
		rm $doc
	done
	cp -R * "${D}${MY_HTDOCSDIR}"
	webapp_serverowned ${MY_HTDOCSDIR}/attach
	webapp_serverowned ${MY_HTDOCSDIR}/backup
	webapp_serverowned ${MY_HTDOCSDIR}/cache
	webapp_serverowned ${MY_HTDOCSDIR}/counter
	webapp_serverowned ${MY_HTDOCSDIR}/diff
	webapp_serverowned ${MY_HTDOCSDIR}/trackback
	webapp_serverowned ${MY_HTDOCSDIR}/wiki
	webapp_serverowned ${MY_HTDOCSDIR}/wiki.en
	local files=`echo wiki/*.txt wiki.en/*.txt cache/*.dat`
	local file
	for file in ${files}; do
		webapp_serverowned ${MY_HTDOCSDIR}/${file}
	done
	webapp_src_install

}
