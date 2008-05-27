# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim ports of howm( Hitoride Okigaru Wiki Modoki)"
HOMEPAGE="http://www.aise.ics.saitama-u.ac.jp/~seven/howm_vim/"
LICENSE="as-is"
KEYWORDS="~x86 -*"
IUSE=""
SRC_URI="http://www.aise.ics.saitama-u.ac.jp/~seven/howm_vim/howm_vim.tar.bz2"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides Wiki like memo mode
  ,,c : create Memo
  ,,g : grep search Memo
  ,,t : display ToDo
  ,,s : display Schedule
  ,,a : display all Memos

for more information see /use/share/doc/${P}/readme.txt.gz"

S="${WORKDIR}/`basename ${SRC_URI} .tar.bz2`"

# Almost same to vim-pugin_src_install, but one thing, only *.png should to be
# installed doc/html without compressed.
# line 33 of this ebuilds.
src_install() {
	local f

	# Make sure perms are good
	chmod -R a+rX ${S}

	# Install non-vim-help-docs
	cd ${S}
	for f in *; do
		[[ -f "${f}" ]] || continue
		if [[ "${f}" = *.html ]] || [[ "${f}" = *.png ]] ; then
			dohtml "${f}"
		else
			dodoc "${f}"
		fi
		rm -f "${f}"
	done
	
	# Install remainder of plugin
	cd ${WORKDIR}
	dodir /usr/share/vim
	mv ${S} ${D}/usr/share/vim/vimfiles
}

