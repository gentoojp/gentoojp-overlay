# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim plugin: update hatena diary(http://d.hatena.ne.jp) with vim."
HOMEPAGE="http://tokyoenvious.xrea.jp/b/vim/hatena_vim.html"
SRC_URI="http://tokyoenvious.xrea.jp/archives/hatena/hatena.vim-${PV}.zip"

LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
RDEPEND="${RDEPEND}
	net-misc/curl
	app-i18n/qkc"
DEPEND="${RDEPEND}
	app-arch/unzip"
IUSE=""

RESTRICT="mirror"

VIM_PLUGIN_HELPTEXT=\
"add below into ~/.vimrc
  let g:hatena_user     = '\$(your user name)'
  let g:hatena_base_dir = '/home/you/.vim/hatena'

and create a cookie directory
  eg.) $ mkdir -p ~/.vim/hatena/cookies"

src_unpack(){
	mkdir ${S}
	cd ${S}
	unpack ${A}
	rmdir ${S}/cookies
	# fix encoding [SJIS/CRLF] -> [EUC-JP/LF]
	qkc -eu */*.vim
}
