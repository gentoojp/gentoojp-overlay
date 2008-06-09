# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

PYTHON_SLOT_VERSION=2.1

inherit distutils

MY_P="${PN%-py21}-${PV/_pre/pre}"

DESCRIPTION="Python Library to download the weather report
 for a given station ID decodes it and the provides easy access to
 all the data found in the report."
HOMEPAGE="http://www.schwarzvogel.de/software-pymetar.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	dodoc readme.sjis
	docinto test; dodoc test/*
	docinto misc; dodoc misc/*
}
