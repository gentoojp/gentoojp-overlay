# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

MY_PN=${PN/-/_}

DESCRIPTION="vim ports of howm( Hitoride Okigaru Wiki Modoki)"
HOMEPAGE="http://sworddancer.funkyboy.jp/howm_vim/"
SRC_URI="http://sworddancer.funkyboy.jp/howm_vim/${MY_PN}.tar.bz2"

LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides Wiki like memo mode
  ,,c : create Memo
  ,,g : grep search Memo
  ,,t : display ToDo
  ,,s : display Schedule
  ,,a : display all Memos

for more information see /use/share/doc/${P}/readme.txt.gz"

S="${WORKDIR}/${MY_PN}"

# Almost same as vim-pugin_src_install, but one thing, only *.png should be
# installed doc/html without compressed.
# line 33 of this ebuilds.
src_install() {
	local f

	# Make sure perms are good
	chmod -R a+rX "${S}"

	# Install non-vim-help-docs
	cd "${S}"
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
	cd "${WORKDIR}"
	dodir /usr/share/vim
	mv ${S} "${D}"/usr/share/vim/vimfiles
}