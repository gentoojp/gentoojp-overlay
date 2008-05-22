inherit eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="C++ STL extensions"
HOMEPAGE="http://www.stlsoft.org/"
SRC_URI="http://synesis.com.au/downloads/stlsoft/${P}-hdrs.zip"
LICENSE="BSD-2"
SLOT="0"

src_unpack() {
	unpack ${A}
}

src_compile() {
	# Nothing to do
	true
}

src_install() {
	cd "${S}/include"
	insinto "/usr/include/${P}"
	doins -r .

	cd "${S}"
	dodoc *.txt
}

src_test() {
	# Nothing to do
	true
}
