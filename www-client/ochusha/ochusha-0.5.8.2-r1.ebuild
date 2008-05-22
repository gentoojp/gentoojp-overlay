# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/ochusha/ochusha-0.5.8.2.ebuild,v 1.4 2005/12/03 17:05:53 tgall Exp $

inherit flag-o-matic

IUSE="nls ssl"

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/16560/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc ppc64 x86"

DEPEND="virtual/xft
	>=x11-libs/gtk+-2.2.4
	>=dev-libs/glib-2.2.3
	>=dev-libs/libxml2-2.5.0
	>=gnome-base/libghttp-1.0.9
	sys-libs/zlib
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	
	cat $O/ochusha-0.5.8.2-r1.ebuild | tail -n 44 | head -n 33 | sed -e "s/^#//" > "${WORKDIR}"/mogera.diff
	cat $O/ochusha-0.5.8.2-r1.ebuild | tail -n 10 | sed -e "s/^#//" > "${WORKDIR}"/glib.diff
	epatch "${WORKDIR}"/mogera.diff

	VERSTR=$(equery w glib) 
	VERSTR=$(echo ${VERSTR##/*/} | sed -e "s/glib-//")
	VER=0
	until [ -z $VERSTR ];
	do
		NUM=$(expr $VERSTR : "\([0-9]*\)")
		VER=$(expr $VER \* 100)
		VER=$(expr $VER + $NUM)
		VERSTR=$(echo $VERSTR | sed -e "s/[0-9]*[^0-9]*//")
	done
	if [ $VER -ge 21001 ]; then
		epatch "${WORKDIR}"/glib.diff
	fi
} 

src_compile() {

	econf $(use_enable nls) \
		$(use_with ssl) \
		--enable-regex \
		--disable-shared \
		--enable-static \
		--with-included-oniguruma || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS ACKNOWLEDGEMENT AUTHORS BUGS \
		ChangeLog INSTALL* NEWS README TODO
}

#
#
#
#diff -Nru ochusha-0.5.8.2.org/lib/ochusha_board_2ch.c ochusha-0.5.8.2/lib/ochusha_board_2ch.c
#--- ochusha-0.5.8.2.org/lib/ochusha_board_2ch.c	2005-08-21 00:01:15.000000000 +0900
#+++ ochusha-0.5.8.2/lib/ochusha_board_2ch.c	2006-05-31 15:31:58.000000000 +0900
#@@ -981,7 +981,7 @@
#   if (board->cookie != NULL)
#     G_FREE(board->cookie);
#   if (cookie != NULL)
#-    board->cookie = G_STRDUP(cookie);
#+      board->cookie = g_strconcat(cookie, "; hana=mogera", NULL); 
#   else
#     board->cookie = NULL;
# }
#diff -Nru ochusha-0.5.8.2.org/lib/ochusha_thread_2ch.c ochusha-0.5.8.2/lib/ochusha_thread_2ch.c
#--- ochusha-0.5.8.2.org/lib/ochusha_thread_2ch.c	2005-09-09 22:18:20.000000000 +0900
#+++ ochusha-0.5.8.2/lib/ochusha_thread_2ch.c	2006-05-31 15:31:54.000000000 +0900
#@@ -1883,7 +1883,7 @@
# 	  && broker->config->login_2ch)
# 	query = g_strdup_printf("submit=%%8F%%91%%82%%AB%%8D%%9E%%82%%DE&FROM=%s&mail=%s&MESSAGE=%s&bbs=%s&key=%s&sid=%s&time=%ld", from, mail, message, bbs, key, broker->config->session_id_2ch, time);
#       else
#-	query = g_strdup_printf("submit=%%8F%%91%%82%%AB%%8D%%9E%%82%%DE&FROM=%s&mail=%s&MESSAGE=%s&bbs=%s&key=%s&time=%ld", from, mail, message, bbs, key, time);
#+	query = g_strdup_printf("hana=mogera&submit=%%8F%%91%%82%%AB%%8D%%9E%%82%%DE&FROM=%s&mail=%s&MESSAGE=%s&bbs=%s&key=%s&time=%ld", from, mail, message, bbs, key, time);
#     }
# 
#   if (query == NULL)
#@@ -1903,7 +1903,7 @@
# 		  && broker->config->login_2ch)
# 		query = g_strdup_printf("submit=%%91%%53%%90%%D3%%94%%43%%82%%F0%%95%%89%%82%%A4%%82%%B1%%82%%C6%%82%%F0%%8F%%B3%%91%%F8%%82%%B5%%82%%C4%%8F%%91%%82%%AB%%8D%%9E%%82%%DE&FROM=%s&mail=%s&MESSAGE=%s&bbs=%s&key=%s&sid=%s&time=%ld", from, mail, message, bbs, key, broker->config->session_id_2ch, time);
# 	      else
#-		query = g_strdup_printf("submit=%%91%%53%%90%%D3%%94%%43%%82%%F0%%95%%89%%82%%A4%%82%%B1%%82%%C6%%82%%F0%%8F%%B3%%91%%F8%%82%%B5%%82%%C4%%8F%%91%%82%%AB%%8D%%9E%%82%%DE&FROM=%s&mail=%s&MESSAGE=%s&bbs=%s&key=%s&time=%ld", from, mail, message, bbs, key, time);
#+		query = g_strdup_printf("hana=mogera&submit=%%91%%53%%90%%D3%%94%%43%%82%%F0%%95%%89%%82%%A4%%82%%B1%%82%%C6%%82%%F0%%8F%%B3%%91%%F8%%82%%B5%%82%%C4%%8F%%91%%82%%AB%%8D%%9E%%82%%DE&FROM=%s&mail=%s&MESSAGE=%s&bbs=%s&key=%s&time=%ld", from, mail, message, bbs, key, time);
# 	    }
# 	  sleep(30);
# 	  post_result = ochusha_utils_2ch_try_post(broker, thread->board,
#
#--- ochusha-0.5.8.2.org/libmodifiedgtk2/Makefile.in	2005-09-19 12:19:00.000000000 +0900
#+++ ochusha-0.5.8.2/libmodifiedgtk2/Makefile.in	2006-05-31 15:31:52.000000000 +0900
#@@ -222,7 +222,7 @@
# libmodifiedgtk2_la_SOURCES = $(LIBSOURCES)
# libmodifiedgtk2_la_LDFLAGS = -version-info $(SOVERSION)
# localedir = $(datadir)/locale
#-AM_CPPFLAGS = -Wall -DG_DISABLE_DEPRECATED -DGDK_PIXBUF_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED $(GLIB_CFLAGS) $(GTK_CFLAGS) -DLOCALEDIR=\"$(localedir)\"
#+AM_CPPFLAGS = -Wall -DG_DISABLE_DEPRECATED -DGDK_PIXBUF_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED $(GLIB_CFLAGS) $(GTK_CFLAGS) -DLOCALEDIR=\"$(localedir)\" -DGTK_COMPILATION
# all: $(BUILT_SOURCES) config.h
# 	$(MAKE) $(AM_MAKEFLAGS) all-am
