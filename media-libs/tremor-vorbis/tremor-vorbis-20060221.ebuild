# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="The Tremor reference decoder provides an integer-only implementation of the decoder for embedded devices"
HOMEPAGE="http://www.xiph.org/vorbis/"

# This is a replace of SRC_URI variable, IMHO.
ESVN_REPO_URI="http://svn.xiph.org/trunk/Tremor/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~arm ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc"

# This is a replace of src_unpack function, IMHO.
ESVN_BOOTSTRAP="autogen.sh"

src_compile() {
	# Enable 32bit only multiply operations
	econf --enable-low-accurancy || die "econf failed. :("

	# DO IT! :)
	emake || die "emake fialed. :("
}

src_install() {
	# Install it.
	make DESTDIR="${D}" install || die "install failed. :("

	# Some documents are.
	dodoc CHANGELOG COPYING README
}
