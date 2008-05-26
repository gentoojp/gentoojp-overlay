# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A real-time video effector for devices supported by video4linux"
HOMEPAGE="http://effectv.sourceforge.net/"
SRC_URI="mirror://sourceforge/effectv/${P}.tar.bz2
	doc? (mirror://sourceforge/effectv/${PN}-docs-${PV}.tar.gz
		mirror://sourceforge/effectv/${PN}-docs-ja-${PV}.tar.gz)"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="mmx doc"
DEPEND="virtual/glibc
	>=media-libs/libsdl-1.1.7
	>=dev-lang/nasm-0.98.34"
	#vloopback? (>=media-video/vloopback-0.90)
RDEPEND="virtual/glibc
	>=media-libs/libsdl-1.1.7"

S=${WORKDIR}/${P}

src_compile() {
	local myconf=""

	use mmx \
		&& myconf="${myconf} USE_MMX=yes" \
		|| myconf="${myconf} USE_MMX=no"

	myconf="${myconf} USE_VLOOPBACK=no"

	make \
		prefix=/usr \
		mandir=/usr/share/man \
		CONFIG.arch="" \
		CFLAGS.opt="${CFLAGS}" \
		${myconf} || die
}


src_install() {
	dodir /usr/{bin,share/man/man1}
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	use doc \
		&& dohtml ${WORKDIR}/EffecTV-webpages/*
}


pkg_postinst() {
	einfo ""
	einfo " EffecTV is a program for Video4Linux devices"
	einfo " Make sure that you have compiled V4L into the kernel"
	einfo " or as a kernel module(videodev.o) and you have access"
	einfo " to /dev/video0 node file to communicate with devices"
	einfo " Current kernel config for V4L is the following."
	einfo ""
	grep '# *CONFIG_VIDEO_DEV' /usr/src/linux/.config > /dev/null \
		&& ewarn "\t$(grep CONFIG_VIDEO_DEV /usr/src/linux/.config)" \
		|| einfo "\t$(grep CONFIG_VIDEO_DEV /usr/src/linux/.config)"
	einfo""
}
