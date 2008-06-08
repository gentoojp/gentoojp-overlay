# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="skf is an i18n-capable kanji filter"
HOMEPAGE="http://www.sourceforge.jp/projects/skf/"
SRC_URI="mirror://sourceforge.jp/${PN}/29384/${P/-/_}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

# truncate last part of version
# skf-1.95.4 -> skf-1.95
S="${WORKDIR}/${P%.*}"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable nls) \
		|| die "econf failed"

	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	use nls && make DESTDIR="${D}" locale_install || die "locale install failed"
}
