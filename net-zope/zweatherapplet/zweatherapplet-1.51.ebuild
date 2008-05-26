# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="Zope product for the weather information"

HOMEPAGE="http://www.librelogiciel.com/software/ZWeatherApplet/action_Presentation"
SRC_URI="mirror://sourceforge/zweatherapplet/ZWeatherApplet-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="<=dev-python/pymetar-py21-0.5"

ZPROD_LIST="ZWeatherApplet"
