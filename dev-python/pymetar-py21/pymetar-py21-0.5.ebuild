# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

PYTHON_SLOT_VERSION=2.1

inherit distutils

P_NEW="${PN%-py21}-${PV/_pre/pre}"

S=${WORKDIR}/${P_NEW}
DESCRIPTION="Python Library to download the weather report 
 for a given station ID decodes it and the provides easy access to 
 all the data found in the report."
SRC_URI="http://www.schwarzvogel.de/pkgs/${P_NEW}.tar.gz"
HOMEPAGE="http://www.schwarzvogel.de/software-pymetar.shtml/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins readme.sjis
	insinto /usr/share/doc/${PF}/test
	doins test/*
	insinto /usr/share/doc/${PF}/misc
	doins misc/*.txt
}
