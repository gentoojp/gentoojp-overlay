# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="The Tremor reference decoder provides an integer-only implementation of the decoder for embedded devices"
HOMEPAGE="http://www.xiph.org/vorbis/"

# This is a replace of SRC_URI variable, IMHO.
# Boo, ESVN_REPO_URI is not implemented "blah? ( http/this.is.uri/foo.tar.gz )"
# like SRC_URI. :/
if use lowmem; then
	ESVN_REPO_URI="http://svn/xiph.org/branches/lowmem-branch/Tremor/"
else
	ESVN_REPO_URI="http://svn.xiph.org/trunk/Tremor/"
fi

LICENSE="as-is"
SLOT="0"
KEYWORDS="~arm ~ppc ~x86"
IUSE="lowmem"

DEPEND="virtual/libc"

pkg_setup() {
	if use lowmem; then
		einfo ""
		einfo "USE=\"lowmem\" is set."
		einfo "So, this ebuild uses tremor-vorbis lowmem branch."
		einfo ""
	else
		einfo ""
		einfo "USE=\"lowmem\" is not set."
		einfo "So, this ebuild uses tremor-vorbis main branch."
		einfo ""
	fi
}

# This is a replace of src_unpack function, IMHO.
ESVN_BOOTSTRAP="autogen.sh"

src_compile() {
	# Enable 32bit only multiply operations.
	econf --enable-low-accurancy || die "econf failed. :("

	# DO IT! :)
	emake || die "emake fialed. :("
}

src_install() {
	# Install it.
	make DESTDIR="${D}" install || die "install failed. :("

	# Some documents are.
	dodoc CHANGELOG README
}
