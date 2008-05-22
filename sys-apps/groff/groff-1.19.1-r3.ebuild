# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.19.1-r2.ebuild,v 1.18 2006/05/08 04:14:27 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs autotools

MB_PATCH="groff_1.18.1-7" #"${P/-/_}-7"
DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz"
# CJK patch from
# 'http://developer.momonga-linux.org/viewcvs/*checkout*/trunk/pkgs/groff/groff-1.19.1-japanese.patch?rev=5111'

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="X cjk"

DEPEND=">=sys-apps/texinfo-4.7-r1
	"
PDEPEND=">=sys-apps/man-1.5k-r1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix the info pages to have .info extensions,
	# else they do not get gzipped.
	epatch "${FILESDIR}"/groff-1.18-infoext.patch

	# Do not generate example files that require us to
	# depend on netpbm.
	epatch "${FILESDIR}"/groff-1.18-no-netpbm-depend.patch

	# Make dashes the same as minus on the keyboard so that you
	# can search for it. Fixes #17580 and #16108
	# Thanks to James Cloos <cloos@jhcloos.com>
	epatch "${FILESDIR}"/${PN}-man-UTF-8.diff

	# Fix stack limit (inifite loop) #64117
	epatch "${FILESDIR}"/${P}-stack.patch

	# Fix tempfile usage #68404
	epatch "${FILESDIR}"/${P}-tmpfile.patch

	# Fix make dependencies so we can build in parallel
	epatch "${FILESDIR}"/${P}-parallel-make.patch

	# Fix some headers to be compatible with gcc-4.1.0
	epatch "${FILESDIR}"/${P}-gcc-4.1.patch

	# CJK patch from momonga linux
	use cjk && epatch "${FILESDIR}"/${P}-japanese-r5111.patch

	# Make sure we can cross-compile this puppy
	if tc-is-cross-compiler ; then
		sed -i \
			-e '/^GROFFBIN=/s:=.*:=/usr/bin/groff:' \
			-e '/^TROFFBIN=/s:=.*:=/usr/bin/troff:' \
			-e '/^GROFF_BIN_PATH=/s:=.*:=:' \
			contrib/mom/Makefile.sub \
			doc/Makefile.in \
			doc/Makefile.sub || die "cross-compile sed failed"
		touch .dont-build-X
	fi
	# Only build X stuff if we have X installed, but do 
	# not depend on it, else we get circular deps :(
	if ! use X || \
	   ! type -p xmkmf > /dev/null || \
	   ! type -p rman > /dev/null || \
	   ! type -p gccmakedep > /dev/null
	then
		touch .dont-build-X
	fi
	eautoreconf
}

src_compile() {
	# Fix problems with not finding g++
	tc-export CC CXX

	# -Os causes segfaults, -O is probably a fine replacement
	# (fixes bug 36008, 06 Jan 2004 agriffis)
	replace-flags -Os -O

	# -march=2.0 makes groff unable to finish the compile process
	use hppa && replace-cpu-flags 2.0 1.0

	# new CJK patch for groff-1.19
	#	$(use_enable cjk japanese)

	# many fun sandbox errors with econf
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=\${inforoot} \
		$(use_enable cjk japanese) \
		|| die
	emake || die

	if [ ! -f .dont-build-X ] ; then
		cd ${S}/src/xditview
		xmkmf || die
		make depend all || die
	fi
}

src_install() {
	dodir /usr /usr/share/doc/${PF}/{examples,html}
	make \
		prefix="${D}"/usr \
		manroot="${D}"/usr/share/man \
		inforoot="${D}"/usr/share/info \
		docdir="${D}"/usr/share/doc/${PF} \
		install || die

	# The following links are required for xman
	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl
	dosym soelim /usr/bin/zsoelim

	dodoc BUG-REPORT ChangeLog FDL MORE.STUFF NEWS \
		PROBLEMS PROJECTS README REVISION TODO VERSION

	if [ ! -f .dont-build-X ] ; then
		cd ${S}/src/xditview
		make DESTDIR="${D}" \
			BINDIR=/usr/bin \
			MANPATH=/usr/share/man \
			install \
			install.man || die
	fi
}
