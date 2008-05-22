# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby

DESCRIPTION="mp3taglib is a id3v1/id3v2 mp3 tagging library for ruby"
SRC_URI="http://rubyforge.org/frs/download.php/68/${P}.tar.gz"
HOMEPAGE="http://rubyforge.org/projects/mp3taglib/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
USE_RUBY="ruby18"

DEPEND="media-libs/id3lib"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${P}.tar.gz || die
	cd ${S}
	epatch ${FILESDIR}/${PF}.patch
}