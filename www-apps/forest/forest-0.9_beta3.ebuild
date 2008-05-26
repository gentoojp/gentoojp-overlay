# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils webapp

MY_P=${PN}-${PV/_/}

DESCRIPTION="Forest is a dictonary consulting software on the internet/intranet."
HOMEPAGE="http://developer.hima.gr.jp/forest/"
SRC_URI="http://developer.hima.gr.jp/forest/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl
    dev-perl/jcode_pl"

S=${WORKDIR}/${MY_P}

src_install() {
	webapp_src_preinst

	PERL_PATH=/usr/bin/perl
	CGI_PATH=${MY_HTDOCSDIR}
	DOC_PATH=${MY_HTDOCSDIR}
	CGI_URI=.
	DOC_URI=.
	
	eval $(grep "^VERSION=" Makefile)

	install -d ${D}/${CGI_PATH}
	install -d ${D}/${DOC_PATH}
	install -d ${D}/${DOC_PATH}/gaiji
	touch ${D}/${DOC_PATH}/gaiji/.keep
	
	for f in \
		input.pl search.pl viewcontents.pl \
		forestcommon.pl forestmsg.pl forest.conf
	do
		sed -e "s!%PERL_PATH%!${PERL_PATH}!g" \
			-e "s!%DOC_PATH%!${DOC_PATH}!g" \
			-e "s!%CGI_PATH%!${CGI_PATH}!g" \
			-e "s!%CGI_URI%!${CGI_URI}!g"	\
			-e "s!%DOC_URI%!${DOC_URI}!g"	\
			-i $f
	done

	sed -e "s!%PERL_PATH%!${PERL_PATH}!g" \
		-e "s!%DOC_PATH%!.!g" \
		-e "s!%CGI_PATH%!.!g" \
		-i loadgaiji.pl

	sed -e "s!2010!2882!g" -i forest.conf

	for f in index.html instruction.html title.html about.html
	do
		sed -e "s!%CGI_URI%!${CGI_URI}!g" \
			-e "s!%VERSION%!${VERSION}!g" \
			-i $f
	done
	
	for f in input.pl search.pl viewcontents.pl forestmsg.pl loadgaiji.pl
	do
		install -m 0755 $f ${D}/${CGI_PATH}/$f
	done
	
	for f in NDTP.pm TCPCLIENT.pm forest.conf forestcommon.pl
	do
		install -m 0644 $f ${D}/${CGI_PATH}/$f
	done
	
	for f in index.html instruction.html about.html title.html forest.jpeg
	do
		install -m 0644 $f ${D}/${DOC_PATH}/$f
	done

	cat <<EOF > ${D}/${DOC_PATH}/.htaccess
order deny,allow
deny from all
allow from 127.0.0.1

<Files "forest.conf">
   Deny from all
</Files>

Options +ExecCGI
AddHandler cgi-script .pl
AddDefaultCharset ISO-2022-JP
EOF

	install -m 0644 $f ${D}/${CGI_PATH}/$f

	webapp_configfile ${MY_HTDOCSDIR}

	dodoc README.ja INSTALL.ja

	webapp_src_install
}
