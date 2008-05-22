# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.10-r1.ebuild,v 1.6 2005/01/19 23:30:24 vapier Exp $

#K_NOUSENAME="yes"
#K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2 
detect_arch
detect_version

COLINUX_VERSION="colinux-0.6.2"

DESCRIPTION="Full sources for the co-operative linux 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/
          http://www.colinux.org/"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
         http://jaist.dl.sourceforge.net/sourceforge/colinux/${COLINUX_VERSION}.tar.gz"
UNIPATCH_LIST="${ARCH_PATCH} ${FILESDIR}/${P}-CAN-2004-1235.patch"

KEYWORDS="~x86 -*"
IUSE=""

src_unpack(){
	kernel-2_src_unpack

	# XXX:
	# since colinux's kernel patch is named 'linux',
	# can't use UNIPATCH function.
	unpack "${COLINUX_VERSION}.tar.gz"
	patch -p1 -f < "${COLINUX_VERSION}/patch/linux" || die

	rm -rf ${COLINUX_VERSION}

	# Pre/Suffix which indicate colinux is added by portage,
	# localversion is not required.
	rm -f ./localversion-cooperative
}

pkg_postinst() {
	postinst_sources 
}

