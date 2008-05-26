# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO
# should fetch other optional scripts as well

DESCRIPTION="An open proxy honeypot written in Perl"

HOMEPAGE="http://world.std.com/~pacman/proxypot.html"

MY_P=${PN}
SRC_URI="http://world.std.com/~pacman/${MY_P}"

# not sure because the author doesn't mention license at all
LICENSE="as-is"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${P}

src_unpack() {
	cp ${DISTDIR}/${MY_P} ${WORKDIR}
}

src_compile() {
	einfo "no need to make."
}

src_install() {
	dobin ${WORKDIR}/${MY_P} || die
}