# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools subversion

ESVN_REPO_URI="http://svn.sourceforge.jp/svnroot/jd4linux/jd/trunk"

DESCRIPTION="gtk2 based 2ch browser written in C++"
HOMEPAGE="http://sourceforge.jp/projects/jd4linux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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

src_unpack() {
	subversion_src_unpack
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
