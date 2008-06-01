# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tgif/tgif-4.1.45.ebuild,v 1.3 2008/02/19 01:46:18 ingmar Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-QPL-${PV}"

DESCRIPTION="Tgif is an Xlib base 2-D drawing facility under X11."
HOMEPAGE="http://bourbon.usc.edu/tgif/index.html"
SRC_URI="ftp://bourbon.usc.edu/pub/${PN}/${MY_P}.tar.gz"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cjk kde"

DEPEND="x11-libs/libX11
	x11-proto/xproto"
RDEPEND="${DEPEND}
	kde? ( || ( =kde-base/kdeprint-3.5* =kde-base/kdebase-3.5* ) )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	use kde && epatch "${FILESDIR}/${P}-kprinter.patch"
	use cjk && epatch "${FILESDIR}/${P}-japanese.patch"
	sed -i \
		-e '/^INSTPGMFLAGS/d' \
		-e 's/#prtgif /prtgif #/' \
		Makefile.noimake || die "sed failed"
}

src_compile() {
	emake -f Makefile.noimake \
		CC=$(tc-getCC) CPPFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake -f Makefile.noimake DESTDIR="${D}" install || die "emake install failed"

	## example-files
	dodoc tgif.Xdefaults tgificon.eps tgificon.obj \
		tgificon.xbm tgificon.xpm tangram.sym eq4.sym eq4-2x.sym \
		eq4-ps2epsi.sym eq4-epstool.sym eq4xpm.sym \
		eq4-lyx-ps2epsi.sym keys.obj

	dodoc README HISTORY
}
