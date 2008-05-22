# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/ekinoco/www-apps/wwwcount/wwwcount-2.5.ebuild,v 1.5 2005/05/15 07:33:29 syuu-cvs Exp $

inherit eutils toolchain-funcs

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://distro.ibiblio.org/pub/linux/distributions/debian/pool/non-free/w/wwwcount/wwwcount_2.5.orig.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64 ~ia64"
RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	cd ${S}.orig
	epatch ${FILESDIR}/${P}-Count-install.patch
	epatch ${FILESDIR}/${P}-src-config-h.patch
}

src_compile() {
	cd ${S}.orig
	BASE_DIR="${D}/var/wwwcount"
	CGIBIN_DIR="${BASE_DIR}/cgi-bin"
	CONFIG_DIR="${BASE_DIR}/conf"
	DIGIT_DIR="${BASE_DIR}/digits"
	DATA_DIR="${BASE_DIR}/data"
	LOG_DIR="${BASE_DIR}/logs"
	RGB_DIR="${BASE_DIR}"
	CONFIG_FILE="count.cfg"
	LOG_FILE="Count2_5.log"
	RGB_FILE="./data/rgb.txt"
	echo "BASE_DIR=${BASE_DIR}" >> ./Config.tmpl
	echo "CGIBIN_DIR=${CGIBIN_DIR}" >> ./Config.tmpl
	echo "CONFIG_DIR=${CONFIG_DIR}" >> ./Config.tmpl
	echo "DIGIT_DIR=${DIGIT_DIR}" >> ./Config.tmpl
	echo "DATA_DIR=${DATA_DIR}" >> ./Config.tmpl
	echo "LOG_DIR=${LOG_DIR}" >> ./Config.tmpl
	echo "RGB_DIR=${RGB_DIR}" >> ./Config.tmpl
	echo "CONFIG_FILE=${CONFIG_FILE}" >> ./Config.tmpl
	echo "LOG_FILE=${LOG_FILE}" >> ./Config.tmpl
	echo "RGB_FILE=${RGB_FILE}" >> ./Config.tmpl
	make all|| die
}

src_install() {
	cd ${S}.orig
	./Count-install
	chown apache:apache -R ${D}/var/wwwcount/data
	sudo -u apache mkdir ${D}/var/wwwcount/logs
	sudo -u apache touch ${D}/var/wwwcount/logs/.keep
}
