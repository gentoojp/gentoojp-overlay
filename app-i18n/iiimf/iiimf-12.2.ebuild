# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Internet Intranet Input Method Framework"
HOMEPAGE="http://www.openi18n.org/"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${PN}-src-${PV}.tar.bz2"

LICENSE="MIT LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="X gtk qt gnome emacs canna freewnn" # m17n-lib java

RDEPEND="virtual/libc
	dev-libs/libxml2
	X? ( virtual/x11 )
	qt? ( >=dev-libs/glib-2.2.2
		>=x11-libs/qt-3.3.3-r1 )
	gnome? ( >=dev-libs/glib-2.1.0
		>=x11-libs/gtk+-2.1.1
		>=gnome-base/libgnomeui-2.2 )
	emacs? ( virtual/emacs )
	canna? ( app-i18n/canna )
	freewnn? ( app-i18n/freewnn )
	!dev-libs/libiiimcf
	!dev-libs/csconv
	!dev-libs/libiiimp
	!app-i18n/iiimsf
	!app-i18n/iiimecf
	!app-i18n/iiimxcf
	!app-i18n/iiimgcf"
#	m17n-lib? ( dev-libs/m17n-lib )
#	java? ( virtual/jdk )

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	dev-util/pkgconfig
	gnome? ( app-text/scrollkeeper
		>=gnome-base/gconf-1.1.9 )"

# An arch specific config directory is used on multilib systems
has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}

pkg_setup() {
	if use qt ; then
		if ! built_with_use -o x11-libs/qt immqt-bc immqt ; then
			eerror "Qt is missing immodule support."
			eerror "Please add immqt-bc or immqt to your USE flags, and re-emerge Qt."
			die "Qt needs immodule suport"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/htt_xbe-fix-build-20040203.patch
	epatch ${FILESDIR}/htt_xbe-fix-crash-134035_140503.patch
	epatch ${FILESDIR}/htt_xbe-fix-x86_64.patch
	epatch ${FILESDIR}/iiimgcf-event-status-done.patch
	epatch ${FILESDIR}/iiimsf-rh-per-user-hotkey.patch
	epatch ${FILESDIR}/im-sdk-iiimgcf-warning.patch
	epatch ${FILESDIR}/leif-unit-rh-fix-build-20040203.patch
	epatch ${FILESDIR}/leif-unit-xdict-silence-txt2bin.patch
	epatch ${FILESDIR}/sun-chinese-le-libdir.patch
	epatch ${FILESDIR}/xiiimp-rh-fix-build-20040203.patch
	epatch ${FILESDIR}/xiiimp-xft.patch

	# leif/sun_le_korea multilib fix
	cd ${S}/leif/sun_le_korea
	sed -i -e "/im_libdir=/s|lib/iiim|$(get_libdir)/iiim|" configure* || die
}

src_compile() {
	local myconf="--with-imdir=/usr/$(get_libdir)/iiim --localstatedir=/var"

	INTLDIRS=""
	BUILDDIRS="lib/CSConv lib/EIMIL lib/iiimp lib/iiimcf iiimsf leif
		leif/sun_le_korea leif/sch_le_sun leif/tch_le_sun"

	use X && BUILDDIRS="${BUILDDIRS} iiimxcf/xiiimp.so iiimxcf/htt_xbe"

	use gtk && BUILDDIRS="${BUILDDIRS} iiimgcf"
	use gtk && INTLDIRS="${INTLDIRS} iiimgcf"

#	use java && BUILDDIRS="${BUILDDIRS} iiimjcf"
	use gnome && BUILDDIRS="${BUILDDIRS} gnome-im-switcher"
	use gnome && INTLDIRS="${INTLDIRS} gnome-im-switcher"

	CONFIGDIRS="${BUILDDIRS} leif/thai_le_sun"
#	use m17n-lib && CONFIGDIRS="${CONFIGDIRS} leif/m17n_le"

	for f in ${INTLDIRS}
	do
		cd ${S}/${f}
		glib-gettextize -f && intltoolize --copy --force --automake || die
	done

	for f in ${CONFIGDIRS}
	do
		cd ${S}/${f}
		autoreconf --install --force || die
	done

	for f in ${BUILDDIRS}
	do
		cd ${S}/${f}
		econf ${myconf} || die "${f} configure failed"
		emake || die "${f} make failed"
	done

	if use qt ; then
		cd ${S}/iiimqcf/src
		qmake || die "iiimqcf qmake failed"
		emake || die "iiimqcf make failed"
	fi

	if use emacs ; then
		cd ${S}/iiimecf
		emacs -q --no-site-file -batch -i iiimcf-comp.el || die
	fi

	# if use java ; then
	# 	cd ${S}/iiimjcf/jdk13_iiimf_adapter/build
	# 	ALT_JDK13_HOME=$(java-config -g JAVA_HOME) make || die
	# fi
}

src_install() {
	BUILDDIRS="lib/CSConv lib/EIMIL lib/iiimp lib/iiimcf iiimsf leif
		leif/sun_le_korea leif/sch_le_sun leif/tch_le_sun"
	
	use X && BUILDDIRS="${BUILDDIRS} iiimxcf/xiiimp.so iiimxcf/htt_xbe"
	use gtk && BUILDDIRS="${BUILDDIRS} iiimgcf"

	for f in ${BUILDDIRS}
	do
		cd ${S}/${f}
		make DESTDIR=${D} install || die "${f} make install failed"
	
	done

	if use gnome ; then
		cd ${S}/gnome-im-switcher
		export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
		make DESTDIR=${D} \
			scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper \
			install || die "gnome-im-switcher make install failed"

		unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
		rm -rf ${D}/var/lib/scrollkeeper

		docinto gnome-im-switcher
		dodoc AUTHORS ChangeLog INSTALL NEWS README
	fi

	if use qt ; then
		cd ${S}/iiimqcf/src
		insinto /usr/qt/3/plugins/inputmethods
		doins libiiimqcf.so || die
		docinto iiimqcf
		dodoc ChangeLog ../README
	fi

	if use emacs ; then
		cd ${S}/iiimecf
		elisp-install iiimecf lisp/*.el lisp/*.elc
		elisp-site-file-install ${FILESDIR}/50iiimecf-gentoo.el
		docinto iiimecf
		dodoc ChangeLog README*
		newdoc lisp/ChangeLog ChangeLog.lisp
	fi

	newinitd ${FILESDIR}/iiimd.init iiimd
}

pkg_postinst() {
	if use gnome ; then
		if [ -x ${ROOT}/usr/bin/scrollkeeper-update ]
		then
			echo ">>> Updating Scrollkeeper"
			scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
		fi

		if [ -x ${ROOT}/usr/bin/gconftool-2 ]
		then
			unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
			export GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
			einfo "Installing GNOME 2 GConf schemas"
			${ROOT}/usr/bin/gconftool-2 --makefile-install-rule ${ROOT}/etc/gconf/schemas/gnome-im-switcher.schemas 1>/dev/null
		fi

	fi

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/${GTK2_CONFDIR}/gtk.immodules
}

pkg_postrm() {
	if use gnome ; then
		if [ -x ${ROOT}/usr/bin/scrollkeeper-update ]
		then
			echo ">>> Updating Scrollkeeper"
			scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
		fi
	fi

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/${GTK2_CONFDIR}/gtk.immodules
}
