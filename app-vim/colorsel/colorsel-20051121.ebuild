# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit vim-plugin

DESCRIPTION="vim plugin: RGB / HSV color selector"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=927"
LICENSE="public-domain"
KEYWORDS="~sparc ~x86 ~mips ~ppc ~amd64 ~alpha ~ia64"
IUSE=""
RDEPEND=">=app-editors/gvim-6.2"
SRC_URI="http://trific.ath.cx/Ftp//vim/scripts/colorsel.vim"
RESTRICT="nomirror"

function src_unpack() {
	mkdir -p ${S}/plugin
	cp ${DISTDIR}/${A} ${S}/plugin/

	# This plugin tests whether the GUI is present and barfs if not. We
	# don't want this, since we don't have a gvim-specific plugins
	# directory. Instead, we'll do a bit of sed-fu to make it just do
	# nothing in non-GUI mode.
	sed -i \
		-e "s:echoerr 'Color selector needs GUI':\" mmm, cookies':" \
		-e "s:0bjlw:0bhlw:" \
		${S}/plugin/${PN}.vim \
		|| die "d'oh! sed magic didn't work, call an ambulance"
}

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a color selector for vim. Use :ColorSel to start
the selector. This command is only available when vim is run in GUI mode."
