# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim plugin: Japanese Input Plugin SKK"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1589"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=6283"

LICENSE="as-is"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="|| ( app-i18n/skk-jisyo virtual/skkserv )"

RESTRICT="mirror"

VIM_PLUGIN_HELPTEXT="Set two global variables if necessary.
  let skk_jisyo = \"path to private dictionary\"
  let skk_large_jisyo = \"path to SKK-JISYO.[SML]\"
:so skk.vim or put this script into your plugin directory.

To start SKK-mode, press <C-j> in Insert-mode or Commandline-mode. "
VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=1589"

src_unpack() {
	mkdir -p "${S}/plugin"
	cd "${S}/plugin"
	unpack ${A}
	sed -i -e '/skk_large_jisyo/{s!/local!!;}' skk.vim
}
