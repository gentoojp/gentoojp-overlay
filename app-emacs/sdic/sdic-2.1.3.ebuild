# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit elisp

DESCRIPTION="SDIC emacs lisp package for Emacs to look English-Japanese/Japanese-English directories"
HOMEPAGE="http://www.namazu.org/~tsuchiya/sdic/"
SRC_URI="http://www.namazu.org/~tsuchiya/sdic/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="
	virtual/emacs
	dev-lang/perl
	app-i18n/nkf
	app-i18n/kakasi"
S=${WORKDIR}/${P}

SITEFILE="50sdic-gentoo.el"

src_unpack() {

	unpack ${A}

	# Insert a info direntry to texi/sdic.texi so as not to fail
	# install-info in post_emerge
	epatch ${FILESDIR}/${P}-infofix.patch

	if [ -e ${DISTDIR}/gene95.tar.gz ] ; then
		cp ${DISTDIR}/gene95.tar.gz ${S}
		DICT="gene95"
	elif [ -e ${DISTDIR}/gene95.tar.bz2 ] ; then
		cp ${DISTDIR}/gene95.tar.bz2 ${S}
		DICT="gene95"
	elif [ -e ${DISTDIR}/gene95.lzh ] ; then
		cp ${DISTDIR}/gene95.lzh ${S}
		DICT="gene95"
	elif [ -e ${DISTDIR}/edict.gz ] ; then
		cp ${DISTDIR}/edict.gz ${S}
		DICT="edict"
	elif [ -e ${DISTDIR}/edict.bz2 ] ; then
		cp ${DISTDIR}/edict.bz2 ${S}
		DICT="edict"
	else
		ewarn "Please download \"GENE95\" or \"EDICT\" "
		ewarn "from ${HOMEPAGE} "
		ewarn "and move it to ${DISTDIR}"
		die
	fi
}

src_compile() {

	econf \
		--with-lispdir=${SITELISP}/${PN} \
		--with-dictdir=/usr/share/dict 

	make || die
	make info || die
	make dict || die
}

src_install() {

	make DESTDIR=${D} install || die

	## Instead of "make install-dict"
	/bin/sh ./mkinstalldirs ${D}/usr/share/dict || die
	if [ ${DICT} = gene95 ] ; then
		/bin/install -c gene.sdic ${D}/usr/share/dict || die
		/bin/install -c jgene.sdic ${D}/usr/share/dict || die
	else
		/bin/install -c eedict.sdic ${D}/usr/share/dict || die
		/bin/install -c jedict.sdic ${D}/usr/share/dict || die
	fi

	# Install info and documents
	doinfo texi/sdic.info	# Instead of "make install-info"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO \
		lisp/sample.emacs

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die	
}
