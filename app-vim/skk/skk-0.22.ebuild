# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim plugin: Japanese Input Plugin SKK"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1589"
LICENSE=""
KEYWORDS="~sparc x86 ~mips ~ppc amd64 ~alpha ~ia64"
IUSE=""

RDEPEND="|| ( app-i18n/skk-jisyo virtual/skkserv)"

SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=6283"
RESTRICT="nomirror"

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT="Set two global variables if necessary.
  let skk_jisyo = \"path to private dictionary\"
  let skk_large_jisyo = \"path to SKK-JISYO.[SML]\"
:so skk.vim or put this script into your plugin directory.
To start SKK-mode, press <C-j> in Insert-mode or Commandline-mode. "
VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=1589"
VIM_PLUGIN_MESSAGES=""

src_unpack() {
	mkdir -p ${S}/plugin
	busybox unzip ${DISTDIR}/${A} -d ${S}/plugin/

	sed -i -e '/skk_large_jisyo/{s!/local!!;}' ${S}/plugin/skk.vim
}
