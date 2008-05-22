# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

DESCRIPTION="Kwaff is a simplified and structured data format for XML target"
HOMEPAGE="http://www.kuwata-lab.com/kwaff/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

#USE_RUBY="any"
RDEPEND="virtual/ruby"
DEPEND="${RDEPEND}"

