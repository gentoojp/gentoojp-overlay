# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="skf is an i18n-capable kanji filter"
HOMEPAGE="http://www.sourceforge.jp/projects/skf/"
SRC_URI="mirror://sourceforge.jp/${PN}/50807/${P/-/_}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P%.*}"

src_configure() {
	econf --disable-dependency-tracking \
		$(use_enable nls) \
		|| die "econf failed"
}

src_compile() {
	# a workaround for parallel build
	emake in_table_defs.h || die "emake in_table_defs.h failed"
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${D}" || die "emake install failed"
	use nls && emake locale_install DESTDIR="${D}" || die "locale install failed"
	use doc && dodoc doc/*
	dodoc CHANGES_ja.txt README.txt

	rm -rf "${ED}"/usr/share/doc/skf
}
