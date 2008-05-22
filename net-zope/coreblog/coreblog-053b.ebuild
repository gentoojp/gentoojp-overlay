# Distributed under the terms of the GNU General Public License v2


inherit zproduct

DESCRIPTION="Zope product for Blog/Weblog/Web Nikki system"

HOMEPAGE="http://coreblog.org/"
SRC_URI="http://zope.org/Members/ats/COREBlog/COREBlog%200.53b/COREBlog${PV}.tgz"
LICENSE="GPL"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="COREBlog"
MYDOC="${MYDOC}"



pkg_postinst()
{
	zproduct_pkg_postinst
	einfo "---> NOTE: Remember to check Add COREBlog Comments for anonymous setting in security tab."
	einfo "---> NOTE: After that, please add some category, so you can begin to add entries. Also please fill up some fields on setting tab."
}
