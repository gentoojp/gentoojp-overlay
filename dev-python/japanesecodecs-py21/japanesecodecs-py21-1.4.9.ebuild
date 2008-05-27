# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PYTHON_SLOT_VERSION=2.1

inherit distutils

P_NEW="${PN%-py21}-${PV/_pre/pre}"
MY_P=${P_NEW/japanesecodecs/JapaneseCodecs}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python Codecs for Japanese Language Encodings like EUC, Shift-JIS, ISO-2022"
SRC_URI="http://www.asahi-net.or.jp/~rd6t-kjym/python/JapaneseCodecs/dist/${MY_P}.tar.gz"
HOMEPAGE="http://www.asahi-net.or.jp/~rd6t-kjym/python/"

SLOT="0"
KEYWORDS="~x86"
LICENSE=""

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/test
	doins test/*
}
