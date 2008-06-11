# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit webapp

DESCRIPTION="Simple feture-rich wiki variant"
HOMEPAGE="http://sourceforge.jp/projects/pukiwiki/"
SRC_URI="!unicode? ( mirror://sourceforge.jp/${PN}/12957/${P}_notb.tar.gz )
		unicode? ( mirror://sourceforge.jp/${PN}/12957/${P}_notb_utf8.tar.gz )"

LICENSE="GPL-2"
SLOT="${PVR}"
KEYWORDS="~x86"
IUSE="unicode"

DEPEND="virtual/httpd-php"
RDEPEND="${DEPEND}"

MY_S=${A/.tar.gz}

src_unpack() {
	unpack ${A}
	cd ${MY_S}
	gunzip *.gz
	tar zxf wiki.en.tgz
	rm wiki.en.tgz
}

src_install() {
	cd ${MY_S}
	webapp_src_preinst
	cat ${FILESDIR}/en.txt >> README.en.txt
	webapp_postinst_txt en README.en.txt
	dodoc COPYING.txt README.txt README.en.txt UPDATING.txt UPDATING.en.txt
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
