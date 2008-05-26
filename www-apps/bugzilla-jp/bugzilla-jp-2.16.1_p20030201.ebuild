# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit webapp

MY_P="bugzilla-${PV/_p/-ja-}"

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://bugzilla.mozilla.gr.jp/files/${MY_P}.tar.gz"
HOMEPAGE="http://bugzilla.mozilla.gr.jp/"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~amd64 ~x86"

IUSE="apache2"

# See http://www.bugzilla.org/docs216/html/stepbystep.html to verify dependancies
# updated list of deps: http://www.bugzilla.org/releases/2.16/release-notes.html
# removed deps:	dev-perl/MIME-tools
RDEPEND=">=dev-db/mysql-3.23.41
	>=dev-lang/perl-5.6.0
	>=dev-perl/AppConfig-1.52
	>=perl-core/CGI-2.93
	>=dev-perl/TimeDate-1.16
	>=dev-perl/DBI-1.36
	>=dev-perl/DBD-mysql-2.1010
	>=perl-core/File-Spec-0.8.2
	>=dev-perl/Template-Toolkit-2.08
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/Chart-2.3
	>=dev-perl/GD-1.20
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/perl-ldap
	>=dev-perl/PatchReader-0.9.4
	dev-perl/XML-Parser
	apache2? ( >=net-www/apache-2.0 )
	!apache2? ( =net-www/apache-1* )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	cd ${S}

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die
	for file in `find -type d -printf "%p/* "`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	cp ${FILESDIR}/apache.htaccess ${D}/${MY_HTDOCSDIR}/.htaccess

	local FILE="bugzilla.cron.daily bugzilla.cron.tab"
	cd ${FILESDIR}
	cp ${FILE} ${D}/${MY_HTDOCSDIR}

	# add the reconfigure hook
	webapp_hook_script ${FILESDIR}/reconfig

	webapp_src_install
}
