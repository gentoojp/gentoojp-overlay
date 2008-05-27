# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="High Quality Reverb and Impulse Response Convolution library including XMMS/Audacious Effect plugins"
HOMEPAGE="http://freeverb3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="audacious"

DEPEND=">=sci-libs/fftw-3.0.1
	media-libs/libsamplerate
	audacious? ( media-sound/audacious
		>=media-libs/libsndfile-1.0.11 )"

src_compile() {
	local myconf="--enable-release"
	myconf="${myconf} $(use_enable audacious)"
	econf $myconf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

