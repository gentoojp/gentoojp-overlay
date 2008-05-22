# Copyright 2004 HOSONO Hidetomo
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/portage/app-emacs/mew-cvs/RCS/mew-cvs-4.3.ebuild,v 1.10 2005/02/18 10:58:46 h12o Exp $

ECVS_AUTH="pserver"
export CVS_RSH="ssh"
ECVS_SERVER="anoncvs.mew.org:/cvsmew"
ECVS_MODULE="mew"
ECVS_BRANCH="HEAD"
ECVS_USER="anoncvs"
ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"
ECVS_SSH_HOST_KEY=""

inherit elisp cvs

IUSE="ssl"

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND="virtual/emacs
	!app-emacs/mew"
RDEPEND="${DEPEND}
	ssl? ( =net-misc/stunnel-4* )"

SITEFILE=50mew-gentoo.el

src_compile() {
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
	emake || die
}

src_install() {
	einstall prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN%%-cvs} \
		etcdir=${D}/${SITELISP}/${PN%%-cvs}/etc \
		mandir=${D}/usr/share/man/man1 || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc 00*

	insinto /etc/skel
	newins mew.dot.mew .mew.el
	newins mew.dot.emacs .emacs.mew
}
