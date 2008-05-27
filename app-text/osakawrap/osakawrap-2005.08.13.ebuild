# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Osakaben Translator and All Dictionarys."
HOMEPAGE="http://yan.m78.com/"
## http://mannequeen.net/~rock/ 
## ^^ mine(installer,wrapper,ebuild creator).
SRC_URI="http://mannequeen.net/~rock/linux/gentoo/portage-dist/${PN}-${PV}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~arm ~hppa"
IUSE="osaka-only doc delegate"

DEPEND="
	>=sys-devel/gcc-2.95.3.20010315
	>=net-misc/wget-1.8.2
	>=app-i18n/nkf-1.7
	>=app-arch/lha-114i
	>=app-arch/unzip-5.31
	>=app-arch/tar-1.13.25
"

S="${WORKDIR}/osaka"

src_compile(){
	if use osaka-only ;then
		PREFIX='/usr' \
		./tools.sh compile-osaka || die
	else
		epatch lha114gUp.patch &&

		PREFIX='/usr' \
		./tools.sh compile || die
	fi
}

src_install(){
	PREFIX='/usr' \
	INSTBINDIR="${D}/usr/bin" \
	./tools.sh install-bin || die

	if use delegate ;then
		INSTCFIDIR="${D}/usr/share/delegate" \
		./tools.sh install-cfi || die
		newconfd ${FILESDIR}/delegated-osaka.confd delegated-osaka
		newinitd ${FILESDIR}/delegated-osaka.initd delegated-osaka
	fi

	if use doc; then
		INSTDOCDIR="${D}/usr/doc/${P}" \
		./tools.sh install-doc || die
	fi
}
