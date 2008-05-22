# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

IUSE=""

DESCRIPTION="Desktop mascot currently called that like 'Are Igai No Nanika' for X"
SRC_URI="mirror://sourceforge.jp/${PN}/17774/${P}.tgz"
HOMEPAGE="http://www.geocities.co.jp/SiliconValley-Cupertino/7565/
	http://ninix-aya.sourceforge.jp/"

DEPEND=">=dev-lang/python-2.4
	>=x11-libs/gtk+-2.4
	dev-python/numeric
	>=dev-python/pygtk-2.4.1
	app-arch/unzip
	app-arch/lha"

KEYWORDS="~x86 ~alpha"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${P}"

pkg_setup(){
	python_version
}

src_unpack(){
	unpack ${A}

	local DIR="modules"
	for EACH in ${DIR}
	do
	  (
		  cd ${S}/${EACH}

		  mv Makefile.${EACH} Makefile.${EACH}.orig
		  sed -e "s/^\([[:blank:]]\+-cp\)/#\1/" \
			  Makefile.${EACH}.orig > Makefile.${EACH}
	  )
	done
}

src_compile(){
	emake prefix=/usr \
		exec_libdir=/usr/lib/python${PYVER}/site-packages/${PN} \
		docdir=/usr/share/doc/${PF} \
		NINIX=ninix \
		NINIX_INSTALL=ninix-install \
		NINIX_LOOKUP=ninix-lookup \
		NINIX_UPDATE=ninix-update \
		|| die "Compile failed."
}

src_install(){
	emake DESTDIR=${D} \
		prefix=/usr \
		exec_libdir=/usr/lib/python${PYVER}/site-packages/${PN} \
		docdir=${D}/usr/share/doc/${PF} \
		NINIX=ninix \
		NINIX_INSTALL=ninix-install \
		NINIX_LOOKUP=ninix-lookup \
		NINIX_UPDATE=ninix-update \
		install || die "Install failed."

	cd ${S}/doc
	docinto doc
	dodoc *
	prepalldocs
}
