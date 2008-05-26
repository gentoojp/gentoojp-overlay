# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

DESCRIPTION="GentooJP Testing Portage Tree"
HOMEPAGE="http://www.gentoo.gr.jp/"
SRC_URI=""

DEPEND="virtual/libc"

KEYWORDS="x86 alpha sparc ppc ppc64 mips hppa amd64 ia64 arm"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="nomirror"

S="${WORKDIR}/${PN}"

pkg_setup(){
	if [ -z "${PORTDIR_OVERLAY_JP}" ]; then
		eerror
		eerror "You must set PORTDIR_OVERLAY_JP in /etc/make.conf"
		eerror
		eerror "Example:"
		eerror "	PORTDIR_OVERLAY_JP=\"/usr/local/portagejp\""
		eerror
		die
	fi

	wget http://ebuild.gentoo.gr.jp/distfiles/${PN}.tbz2 -P ${T} || die "Download failed."
}

src_unpack(){
	tar jxf ${T}/${PN}.tbz2 || die "Unpack failed."
}

src_compile(){
	return
}

src_install(){
	dodir ${PORTDIR_OVERLAY_JP}
	cp -r * ${D}/${PORTDIR_OVERLAY_JP}
}

pkg_postinst(){
	echo
	ewarn
	ewarn "You must add value of PORTDIR_OVERLAY_JP to PORTDIR_OVERLAY"
	ewarn
	ewarn "Example:"
	ewarn "	PORTDIR_OVERLAY_JP=\"/usr/local/portagejp\""
	ewarn "	PORTDIR_OVERLAY=\"\${PORTDIR_OVERLAY_JP} \${PORTDIR_OVERLAY}\""
	ewarn
	echo
}
