# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="Scim-ruby is an IM engine module of SCIM to run one-line Ruby codes."
HOMEPAGE="http://scim-ruby.sourceforge.jp/cgi-bin/hiki.cgi"
SRC_URI="mirror://sourceforge.jp/scim-ruby/22855/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/scim-1.0
	>=dev-ruby/ruby-gtk2-0.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

each_ruby_install() {
	emake install DESTDIR="${D}" || die "make install failed"
}

all_ruby_install() {
	dodoc AUTHORS README
}

