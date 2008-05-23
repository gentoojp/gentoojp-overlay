# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

MY_P=${P/_p/-}
MY_P=${MY_P/_/-}
SF_DLID="30565"

DESCRIPTION="gtk2 based 2ch browser written in C++"
HOMEPAGE="http://jd4linux.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/jd4linux/${SF_DLID}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome openssl"

RDEPEND=">=dev-cpp/gtkmm-2.8
	media-libs/libpng
	>=sys-libs/zlib-1.2
	openssl? ( >=dev-libs/openssl-0.9.7 )
	!openssl? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	local myconf=""

	# use gnomeui sm instead of Xorg SM/ICE
	use gnome && myconf="${myconf} --with-sessionlib=gnomeui"

	econf \
		$(use_with openssl) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doicon ${PN}.png
	domenu ${PN}.desktop
	dodoc COPYING README ChangeLog
}
