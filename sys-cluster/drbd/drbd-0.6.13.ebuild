# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

LICENSE="GPL-2"
KEYWORDS="~x86"

DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://oss.linbit.com/drbd/0.6/drbd-${PV}.tar.gz"
HOMEPAGE="http://www.drbd.org"

IUSE=""
RESTRICT="mirror"

DEPEND="virtual/linux-sources"
RDEPEND=">=sys-cluster/heartbeat-1.0.4"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.vars.patch
	cd drbd
	epatch ${FILESDIR}/${PV}-module-Makefile.patch
	cd ..
	cd scripts
	epatch ${FILESDIR}/${PV}-scripts-Makefile.patch
	cd ${S}
}

src_compile() {
	check_KV
	einfo ""
	einfo "Your kernel-sources in /usr/src/linux-${KV} must be properly configured"
	einfo "and match the currently running kernel version ${KV}"
	einfo "If otherwise -> build will fail."
	einfo ""
	cd ${S}
	cp -R /usr/src/linux-${KV} ${WORKDIR}
	emake KDIR=/${WORKDIR}/linux-${KV} || die "compile problem"
}

