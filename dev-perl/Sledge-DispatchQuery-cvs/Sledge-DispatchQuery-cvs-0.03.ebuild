# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ECVS_SERVER="cvs.sourceforge.jp:/cvsroot/sledge"
ECVS_MODULE="Sledge-DispatchQuery"
S=${WORKDIR}/${ECVS_MODULE}

IUSE=""

inherit perl-module cvs

DESCRIPTION="Sledge-DispatchQuery."
SRC_URI=""
HOMEPAGE="http://sl.edge.jp/"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

DEPEND="dev-perl/Sledge"
