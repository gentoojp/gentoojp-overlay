# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim plugin: update hatena diary(http://d.hatena.ne.jp) from vim."
HOMEPAGE="http://tokyoenvious.xrea.jp/b/vim/hatena_vim.html"
LICENSE="as is"
KEYWORDS="~x86"
IUSE=""
RDEPEND="${RDEPEND}
         net-misc/curl
		 app-i18n/qkc"

SRC_URI="http://tokyoenvious.xrea.jp/archives/hatena/hatena.vim-${PV}.zip"
RESTRICT="nomirror"

VIM_PLUGIN_HELPTEXT=\
"add your vim below
  let g:hatena_user     = '\$(your user name)'
  let g:hatena_base_dir = '/home/you/.vim/hatena'

and create cookie directory
  eg.) $ mkdir -p ~/.vim/hatena/cookies
"

src_unpack(){
	mkdir ${S}
	cd ${S}
	unpack ${A}
	rmdir ${S}/cookies
	# fix encoding [SJIS/CRLF] -> [EUC-JP/LF]
	find . -name \*.vim -type f -exec qkc -eu {} \;
}

