# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="High Quality Reverb and Impulse Response Convolution library including XMMS/Audacious Effect plugins"
HOMEPAGE="http://freeverb3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="audacious plugdouble sse sse2 3dnow forcefpu"

DEPEND=">=sci-libs/fftw-3.0.1
	audacious? ( media-sound/audacious
		>=media-libs/libsndfile-1.0.11 )"

src_compile() {
	econf \
		--enable-release \
		$(use_enable audacious) \
		$(use_enable plugdouble) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable 3dnow) \
		$(use_enable forcefpu) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
