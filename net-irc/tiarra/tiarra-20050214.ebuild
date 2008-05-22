DESCRIPTION="Tiarra is pure-perl irc proxy(or bot) software."
HOMEPAGE="http://www.clovery.jp/tiarra/"
SRC_URI="http://www.clovery.jp/tiarra/archive/2005/02/${P}.tar.bz2"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-lang/perl-5.6"

src_install() {
	newbin "${FILESDIR}/tiarra.sh" tiarra || die "newbin failed"

	insinto /usr/lib/tiarra
	doins -r main module || die "doins failed"
	exeinto /usr/lib/tiarra
	doexe tiarra || die "doexe failed"

	dodoc AUTHORS ChangeLog HACKING LICENSE NEWS sample.conf
	dohtml -r doc/*
}

pkg_postinst() {
	einfo
	einfo "Now edit your ~/.tiarra/tiarra.conf"
	einfo
}
