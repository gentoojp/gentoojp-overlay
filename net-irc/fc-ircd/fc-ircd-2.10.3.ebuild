# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PATCHVER="fc06"
DESCRIPTION="A ircd with ipv6 support use by the Friend Chat network"
HOMEPAGE="http://www.friend.td.nu/ircd-fc.html"
SRC_URI="ftp://ftp.fan.gr.jp/pub/IRC/fc-ircd/irc${PV}-${PATCHVER}.tar.bz2"
LICENSE="GPL-1"
SLOT="0"
RESTRICT="mirror"

# The only architecture I can test
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="zlib ipv6"

DEPEND="sys-libs/glibc
	sys-libs/ncurses
	zlib? ( sys-libs/zlib )"

RDEPEND="sys-apps/sed
	sys-apps/grep
	sys-apps/textutils"

S=${WORKDIR}/irc${PV}-${PATCHVER}

src_compile () {

	IRCUID=`grep ^ircd: /etc/passwd | cut -d : -f 3`
	IRCGID=`grep ^ircd: /etc/group | cut -d : -f 3`
	if [ -z "$IRCGID" ]
	then
		IRCGID=`grep ^ircd: /etc/passwd | cut -d : -f 4`
	fi

	if [ -z "$IRCUID" ]
	then
		IRCUID=0
		until [ -z "`cut -d : -f 3 /etc/passwd | grep $IRCUID`" ]
		do
			IRCUID=$RANDOM
		done
	fi

	if [ -z "$IRCGID" ]
	then
		IRCGID=0
		until [ -z "`cut -d : -f 3 /etc/group | grep $IRCGID`" ]
		do
			IRCGID=$RANDOM
		done
	fi

	echo -n "$IRCUID" > ${T}/user
	echo -n "$IRCGID" > ${T}/group

	cd ${S}/support
	sed \
		-e "s/^#undef\tOPER_KILL$/#define\tOPER_KILL/" \
		-e "s/^#undef\tOPER_RESTART$/#define\tOPER_RESTART/" \
		-e "s/^#undef TIMEDKLINES$/#define\tTIMEDKLINES\t60/" \
		-e "s/^#undef\tR_LINES$/#define\tR_LINES/" \
		-e "s/^#undef\tCRYPT_OPER_PASSWORD$/#define\tCRYPT_OPER_PASSWORD/" \
		-e "s/^#undef\tCRYPT_LINK_PASSWORD$/#define\tCRYPT_LINK_PASSWORD/" \
		-e "s/^#undef\tIRC_UID$/#define\tIRC_UID\t$IRCUID/" \
		-e "s/^#undef\tIRC_GID$/#define\tIRC_GID\t$IRCGID/" \
		-e "s/^#undef USE_SERVICES$/#define\tUSE_SERVICES/" \
		config.h.dist > config.h.dist~
	mv -f config.h.dist~ config.h.dist

	use zlib && sed -e "s/^#undef\tZIP_LINKS$/#define\tZIP_LINKS/" config.h.dist > config.h.dist~
	mv -f config.h.dist~ config.h.dist

	cd ..

	use zlib && myconf="--with-zlib" || myconf="--without-zlib"
	use ipv6 && myconf="$myconf --with-ip6" || myconf="$myconf --without-ip6"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		'--mandir=${prefix}/share/man' \
		--sysconfdir=/etc/ircd \
		--localstatedir=/var/run/ircd \
		--logdir=/var/log/ircd \
		$myconf || die

	cd `support/config.guess`
	sed \
	  -e "s/^#define USE_POLL 1$/#undef USE_POLL/" \
	setup.h > setup.h~
	mv -f setup.h~ setup.h
	emake ircd iauth chkconf ircd-mkpasswd ircdwatch tkserv || die
}

src_install() {

	cd `support/config.guess`
	make \
		prefix=${D}/usr \
		ircd_conf_dir=${D}/etc/ircd \
		ircd_var_dir=${D}/var/run/ircd \
		ircd_log_dir=${D}/var/log/ircd \
		install-server install-tkserv || die

	dodir /var/run/ircd
	fowners `cat ${T}/user`:`cat ${T}/group` /var/run/ircd
	dodir /var/log/ircd
	fowners `cat ${T}/user`:`cat ${T}/group` /var/log/ircd
	touch auth opers rejects users
	insinto /var/log/ircd
	doins auth opers rejects users
	fowners `cat ${T}/user`:`cat ${T}/group` /var/log/ircd/auth
	fowners `cat ${T}/user`:`cat ${T}/group` /var/log/ircd/opers
	fowners `cat ${T}/user`:`cat ${T}/group` /var/log/ircd/rejects
	fowners `cat ${T}/user`:`cat ${T}/group` /var/log/ircd/users

	cd ../doc
	dodoc *-New alt-irc-faq Authors BUGS ChangeLog Etiquette example.conf \
		iauth-internals.txt INSTALL.appendix INSTALL.* LICENSE \
		m4macros README* RELEASE* rfc* SERVICE*
	docinto Juped
	dodoc Juped/Advertisement Juped/ChangeLog.* Juped/INSTALL
	docinto Juped/US-Admin
	dodoc Juped/US-Admin/Networking
	docinto Nets
	dodoc Nets/IRCNet
	docinto Nets/Europe
	dodoc Nets/Europe/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/ircd.rc ircd

}

pkg_postinst() {
	groupadd -g `cat ${T}/group` -o ircd
	useradd -c "IRCd server user" -d /etc/ircd -g `cat ${T}/group` -o -s /bin/false -u `cat ${T}/user` ircd
}
