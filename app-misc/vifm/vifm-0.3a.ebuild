# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vifm/vifm-0.2a.ebuild,v 1.9 2005/11/01 20:21:40 nelchael Exp $

DESCRIPTION="Console file manager with vi/vim-like keybindings"
HOMEPAGE="http://vifm.sourceforge.net/"
SRC_URI="mirror://sourceforge/vifm/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 s390 amd64 ~ppc"
IUSE=""
DEPEND=">=sys-apps/sed-4.0"

src_unpack() {
	unpack ${A}

	sed -i -e "s:(datadir)/@PACKAGE@:(datadir)/${P}:" \
		Makefile.in

	cd src
	sed -i -e "s:(datadir)/@PACKAGE@:(datadir)/${P}:" \
		Makefile.in

	sed -i -e "s:/usr/local/share/vifm:/usr/share/${P}:g" \
		config.c
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc INSTALL AUTHORS TODO README
}

pkg_postinst() {
	einfo "To use vim to view the vifm help, copy /usr/share/${P}/vifm.txt"
	einfo "to ~/.vim/doc/ and run ':helptags ~/.vim/doc' in vim"
	einfo "Then edit ~/.vifm/vifmrc${PV/a/} and set USE_VIM_HELP=1"
	einfo ""
	einfo "To use the vifm plugin in vim, copy /usr/share/${P}/vifm.vim to"
	einfo "/usr/share/vim/vimfiles/plugin/"
}
