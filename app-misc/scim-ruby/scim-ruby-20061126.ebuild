# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

SFN="22855"
DESCRIPTION="Scim-ruby is an IM engine module of SCIM to run one-line Ruby codes."
HOMEPAGE="http://scim-ruby.sourceforge.jp/cgi-bin/hiki.cgi"
SRC_URI="mirror://sourceforge.jp/scim-ruby/${SFN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.0 >=app-i18n/scim-cvs-1.0 )
		|| ( >=dev-lang/ruby-1.8 )
		|| ( >=dev-ruby/ruby-gtk2-0.10 )"

RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS README
}

