# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="IBAM is an advanced battery monitor for laptops"

HOMEPAGE="http://ibam.sourceforge.net/"

SRC_URI="mirror://sourceforge/ibam/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc sys-devel/gcc-config"

src_compile() {

	emake || die

	if [ -x /usr/bin/gkrellm2 ]; then
		einfo "Building plugin for gkrellm-2.*"
		emake krell || die
	fi

	if [ -x /usr/bin/gkrellm ]; then
		einfo "Building plugin for gkrellm-1.*"
		emake krell1 || die
	fi
}

src_install() {

	dobin ibam

	if [ -f ${S}/ibam-krell.so ]; then
		einfo "Installing plugin for gkrellm-2.*"
		insinto /usr/lib/gkrellm2/plugins
		doins ibam-krell.so
	fi

	if [ -f ${S}/ibam-krell1.so ]; then
		einfo "Installing plugin for gkrellm-1.*"
		insinto /usr/lib/gkrellm/plugins
		doins ibam-krell1.so
	fi

	dodoc CHANGES README REPORT
}
