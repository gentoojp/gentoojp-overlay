# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit perl-module

MY_P="mecab-perl-0.81"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MeCab library module for Perl."
SRC_URI="http://prdownloads.sourceforge.jp/mecab/15083/${MY_P}.tar.gz"
HOMEPAGE="http://chasen.org/~taku/software/mecab/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-text/mecab-0.81"
