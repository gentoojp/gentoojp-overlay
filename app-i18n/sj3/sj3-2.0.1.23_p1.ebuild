# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils

MY_P="${P/_/}"

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://code.google.com/p/sj3/"
SRC_URI="http://sj3.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-lang/lua"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewuser sj3 -1 -1 /var/lib/sj3
	enewgroup sj3
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--with-external-lua \
		--localstatedir="${EPREFIX}/var/lib/sj3" \
		--with-user=sj3 \
		--with-group=sj3 \
		--disable-dependency-tracking \
		|| die "econf failed"

	sed -i -e '/^#define SOCKDIR / s@".*"@"'"${EPREFIX}"'/var/run/sj3"@' \
		-e '/^#define SOCKETNAME / s@".*"@"'"${EPREFIX}"'/var/run/sj3/sj3serv.socket"@' \
		config.h || die
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	sed -e 's/sj3serv/sj3proxy/g' "${FILESDIR}"/sj3serv > "${WORKDIR}"/sj3proxy
	doinitd "${FILESDIR}"/sj3serv "${WORKDIR}"/sj3proxy || die
	insinto /etc/sj3
	doins "${FILESDIR}"/sj3{serv,proxy}.lua.example
	dodoc CHANGES.eucJP README*

	keepdir /var/run/sj3
	fowners sj3:sj3 /var/run/sj3

	rm -rf "${ED}"/usr/share/{examples,doc/sj3}
	find "${ED}" -name '*.la' -exec rm -f '{}' +
}

