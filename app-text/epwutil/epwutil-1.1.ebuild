# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="EPWUTIL, squeeze and more utility for EPWING."
HOMEPAGE="http://openlab.ring.gr.jp/edict/"
SRC_URI="http://openlab.jp/edict/epwutil/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~arm ~hppa"
IUSE=""

src_compile() {
	emake -f makefile.unx || die "emake failed"
}

src_install() {
	dobin bookinfo catdump squeeze
	dodoc README
}
