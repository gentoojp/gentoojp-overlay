# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/Plone-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
SLOT="2.1"
IUSE=""
RDEPEND=">=dev-lang/python-2.3
        >=net-zope/zope-2.7.7
        >=net-zope/cmf-1.5.4
        >=net-zope/cmfformcontroller-1.0.5
        >=net-zope/cmfquickinstallertool-1.5.5
        >=net-zope/cmfactionicons-0.9
        >=net-zope/btreefolder2-1.0.2
        >=net-zope/groupuserfolder-3.4
        >=net-zope/placelesstranslationservice-1.2.1
        >=net-zope/ploneerrorreporting-0.11
        >=net-zope/plonetranslations-2.1
        >=net-zope/plonelanguagetool-0.7
        >=net-zope/securemailhost-1.0.1
        >=net-zope/extendedpathindex-2.1
        >=net-zope/resourceregistries-1.0.4
        >=net-zope/atreferencebrowserwidget-1.1
        >=net-zope/atcontenttypes-1.0
        >=net-zope/cmfdynamicviewfti-1.0.1
        >=net-zope/archetypes-1.3.4
        >=net-zope/kupu-1.3
        >=net-zope/externaleditor-0.9.1
        >=app-admin/zope-config-0.5
        ${RDEPEND}"

ZPROD_LIST="Plone-2.1.2"

