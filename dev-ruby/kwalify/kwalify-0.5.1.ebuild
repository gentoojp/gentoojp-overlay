# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

DESCRIPTION=""
HOMEPAGE="http://www.kuwata-lab.com/kwalify/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

#USE_RUBY="any"
RDEPEND="virtual/ruby"
DEPEND="${RDEPEND}"

