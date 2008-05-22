# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-mail/qmailadmin/qmailadmin-1.0.6.ebuild,v 1.2 2004/01/05 08:49:44 robbat2 Exp $

inherit gnuconfig

DESCRIPTION="A web interface for managing a qmail system with virtual domains."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.inter7.com/${PN}.html"
RESTRICT="nomirror"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-mail/qmail
		>=net-mail/vpopmail-5.2.1-r9
		net-mail/autorespond"

RDEPEND="${DEPEND}
		net-www/apache"

src_unpack() {
	unpack ${A}
	cd ${S}
	for i in alias.c auth.c autorespond.c command.c qmailadmin.c template.c user.c ;do
		sed -e 's|Maildir|.maildir|g' -i $i || die "Failed to change s/Maildir/.maildir/g in $i"
	done
	gnuconfig_update
}

src_compile() {
	local dir_vpopmail="/var/vpopmail"
	local dir_vhost="/var/www/localhost"
	local dir_htdocs="${dir_vhost}/htdocs/${PN}"
	local dir_htdocs_images="${dir_htdocs}/images"
	local url_htdocs_images="/${PN}/images"
	local dir_cgibin="${dir_vhost}/cgi-bin"
	local url_cgibin="/cgi-bin/${PN}"
	local dir_htdocs_htmlib="/usr/share/${PN}"
	local dir_qmail="/var/qmail"
	local bin_true="/bin/true"
	local dir_ezmlm="/usr/bin"
	local dir_autorespond="/var/qmail/bin"

	econf ${myopts} \
	--enable-vpopmaildir=${dir_vpopmail} \
	--enable-htmldir=${dir_htdocs} \
	--enable-imageurl=${url_htdocs_images} \
	--enable-imagedir=${dir_htdocs_images} \
	--with-htmllibdir=${dir_htdocs_htmlib} \
	--enable-qmaildir=${dir_qmail} \
	--enable-true-path=${bin_true} \
	--enable-ezmlmdir=${dir_ezmlm} \
	--enable-cgibindir=${dir_cgibin} \
	--enable-cgipath=${url_cgibin} \
	--enable-autoresponder-path=${dir_autorespond} \
	--enable-domain-autofill \
	--enable-no-cache \
	--enable-maxusersperpage=50 \
	--enable-maxaliasesperpage=50 \
	--enable-vpopuser=vpopmail \
	--enable-vpopgroup=vpopmail \
	|| die "econf failed"

	for i in Makefile ; do
	  sed -e 's|/usr/share/|${datadir}/|g' -i $i || die "Failed to change s|/usr/share|${datadir}|g in $i"
	  sed -e 's|datadir = /usr/share|datadir = ${prefix}/share|g' -i $i || die "Failed to change s|datadir = /usr/share|datadir = ${prefix}/share"
	done

	emake || die
}

src_install () {
        local dir_vhost="/var/www/localhost"
        local dir_htdocs="${dir_vhost}/htdocs/${PN}"
        local dir_htdocs_images="${dir_htdocs}/images"
        local url_htdocs_images="/${PN}/images"
        local dir_cgibin="${dir_vhost}/cgi-bin"
        local url_cgibin="/cgi-bin/${PN}"
        local dir_htdocs_htmlib="/usr/share/${PN}"

	make DESTDIR=${D} install-exec || die

	dodir ${dir_htdocs_htmlib}
        insinto ${dir_htdocs_htmlib}/html
        doins html/*
	newins html/en en-us
	dodir ${dir_htdocs_images}/${PN}
	insinto ${dir_htdocs_images}/${PN}
	doins images/*

	dodoc AUTHORS INSTALL BUGS TODO ChangeLog COPYING NEWS FAQ README
}
