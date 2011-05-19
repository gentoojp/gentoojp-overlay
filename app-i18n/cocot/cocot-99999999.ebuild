# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

if [[ "${PV}" == 9999* ]]; then
	inherit autotools git-2
	EGIT_REPO_URI="git://github.com/vmi/cocot.git"
else
	SRC_URI="http://vmi.jp/software/cygwin/${P}.tar.bz2"
fi

DESCRIPTION="COde COnverter on Tty"
HOMEPAGE="http://vmi.jp/software/cygwin/cocot.html"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/libiconv"
DEPEND="${RDEPEND}"

src_prepare() {
	[[ "${PV}" == 9999* ]] && eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* NEWS README* UNICODE_MEMO
}
