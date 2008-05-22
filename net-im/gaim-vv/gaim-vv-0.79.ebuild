# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-im/gaim-vv/gaim-vv-0.79.ebuild,v 1.1 2004/08/20 16:22:55 okayama Exp $

inherit eutils flag-o-matic gcc
use debug && inherit debug

DESCRIPTION="A friendly fork of the gaim project to concentrate on video and voice support, which will eventually be backported."

HOMEPAGE="http://gaim-vv.sourceforge.net/"

MY_P="gaim-${PV}-vv-3"
SRC_URI="mirror://sourceforge/gaim-vv/${MY_P}.tar.gz
	cjk? http://www.cc.rim.or.jp/~yaz/gaim-${PV}_jp.patch.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="nls perl spell nas debug crypt cjk gnutls silc evo krb4 upnp"

DEPEND="!net-im/gaim
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	sys-devel/gettext
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.8.2-r1
		!<dev-perl/ExtUtils-MakeMaker-6.17 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	dev-libs/nss
	gnutls? ( net-libs/gnutls )
	krb4? ( app-crypt/mit-krb5 )
	silc? ( >=net-im/silc-toolkit-0.9.12-r2 )
	evo? ( mail-client/evolution )
	>=media-libs/libj2k-0.0.8
	=net-libs/libosip-0.9*
	=net-im/linphone-im-0.12*
	upnp? ( net-misc/upnp )"

PDEPEND="crypt? ( >=x11-plugins/gaim-encryption-2.28 )"

#PROVIDE="virtual/gaim"

S=${WORKDIR}/${MY_P}

print_gaim_warning() {

	ewarn
	ewarn "If you are merging ${P} from an earlier version, you will need"
	ewarn "to re-merge any plugins like gaim-encryption or gaim-snpp."
	ewarn
	ewarn "If you experience problems with gaim, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with gaim's sourceforge tracker, and by all means DO NOT"
	ewarn "seek help in #gaim."
	ewarn
	ewarn "Be sure to USE=\"debug\" and include a backtrace for any seg"
	ewarn "faults, see http://gaim.sourceforge.net/gdb.php for details on"
	ewarn "backtraces."
	ewarn
	ewarn "Please read the gaim FAQ at http://gaim.sourceforge.net/faq.php"
	ewarn
	for TICKER in 1 2 3 4 5; do
		# Double beep here.
		echo -ne "\a" ; sleep 0.11
		echo -ne "\a" ; sleep 1
	done
	sleep 3
}

pkg_setup() {

	print_gaim_warning
}

src_unpack() {

	unpack ${A}

	cd ${S}/src/protocols/msn/
	epatch ${FILESDIR}/gaim-0.81_msn-slp.diff

	cd ${S}
#	epatch ${FILESDIR}/gaim-0.81cvs-gtkblist_dnd.diff
#	epatch ${FILESDIR}/gaim-0.81cvs-icon_scaling.diff
	epatch ${FILESDIR}/gaim-0.81cvs-irc-ison-lessflood.patch
	epatch ${FILESDIR}/gaim-0.81cvs-chatbutton-crashfix.patch
	epatch ${FILESDIR}/gaim-0.82cvs-gtkprefs-fix.patch

	if use cjk ; then
		epatch ../gaim-${PV}_jp.patch
		epatch ${FILESDIR}/gaim-0.76-xinput.patch
	fi
}

src_compile() {

	einfo
	einfo "Note that we are now filtering all unstable flags in C[XX]FLAGS."
	einfo

	# Stabilize things, for your own good
	strip-flags
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf

	use krb4 && myconf="${myconf} --with-krb4=/usr"

	if use gnutls ; then
		myconf="${myconf} --with-gnutls-includes=/usr/include/gnutls"
		myconf="${myconf} --with-gnutls-libs=/usr/lib"
	else
		myconf="${myconf} --enable-gnutls=no"
	fi

	if use silc ; then
		myconf="${myconf} --with-silc-includes=/usr/include/silc-toolkit"
		myconf="${myconf} --with-silc-libs=/usr/lib"
	fi

	myconf="${myconf} --with-nspr-includes=/usr/include/nspr"
	myconf="${myconf} --with-nss-includes=/usr/include/nss"
	myconf="${myconf} --with-nspr-libs=/usr/lib"
	myconf="${myconf} --with-nss-libs=/usr/lib"
	myconf="${myconf} $(use_enable perl)"
	myconf="${myconf} $(use_enable spell gtkspell)"
	myconf="${myconf} $(use_enable nls)"
	myconf="${myconf} $(use_enable nas)"
	myconf="${myconf} $(use_enable evo gevolution)"

	# gaim-vv's original options
	myconf="${myconf} $(use_enable upnp)"
	myconf="${myconf} --with-libj2k=/usr"
	myconf="${myconf} --enable-linphone"
	myconf="${myconf} --enable-msn-vv"

	econf ${myconf} || die "Configuration failed"

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"
}

src_install() {

	make install DESTDIR=${D} || die "Install failed"
	dodoc ABOUT-NLS AUTHORS COPY* HACKING INSTALL NEWS PROGRAMMING_NOTES \
		README{,.gaim-vv} ChangeLog VERSION
}

pkg_postinst() {

	print_gaim_warning
}
