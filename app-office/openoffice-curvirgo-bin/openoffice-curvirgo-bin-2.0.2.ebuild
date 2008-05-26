# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils fdo-mime rpm versionator

IUSE="gnome java kde"

INSTDIR="/opt/OpenOffice.org"

S="${WORKDIR}/RPMS"
DESCRIPTION="The Japanese version of OpenOffice productivity suite built by curvirgo"
#SV="156"
#MY_PV=${PV/_pre1/}
RPM_V="5"
SRC_URI="mirror://sourceforge.jp/waooo/19310/OOo_${PV}_LinuxIntel_install_ja_curvirgo_rpm_core.tar.bz2
	mirror://sourceforge.jp/waooo/19310/OOo_${PV}_LinuxIntel_install_ja_curvirgo_rpm_other.tar.bz2"
RESTRICT="nomirror"

HOMEPAGE="http://waooo.sourceforge.jp/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="!app-office/openoffice
	!app-office/openoffice-bin
	virtual/x11
	virtual/libc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	x11-libs/startup-notification
	java? ( >=virtual/jre-1.4.1 )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"

src_unpack() {
	unpack ${A}

	for i in core01 core02 core03 core04 core05 core03u core04u core05u core06 core07 core08 core09 base calc draw impress math writer graphicfilter pyuno spellcheck testtool xsltfilter; do
		rpm_unpack ${S}/openoffice.org-${i}-${PV}-${RPM_V}.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.org-freedesktop-menus-${PV}-${RPM_V}.noarch.rpm
	use kde && rpm_unpack ${S}/desktop-integration/openoffice.org-suse-menus-${PV}-${RPM_V}.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.org-gnome-integration-${PV}-${RPM_V}.i586.rpm
	use java && rpm_unpack ${S}/openoffice.org-javafilter-${PV}-${RPM_V}.i586.rpm
}

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	dodir /usr/share/icons
	dodir /usr/share/mime
	mv ${WORKDIR}/opt/openoffice.org2.0/* ${D}${INSTDIR}
	mv ${WORKDIR}/usr/share/icons/* ${D}/usr/share/icons

	use kde && dodir /usr/share/mimelnk/application && mv ${WORKDIR}/opt/kde3/share/mimelnk/application/* ${D}/usr/share/mimelnk/application

	#Menu entries
	cd ${D}${INSTDIR}/share/xdg/

	sed -i -e s/'Exec=openoffice.org-2.0-printeradmin'/'Exec=oopadmin2'/g printeradmin.desktop

	dodir /usr/share/pixmaps
	for desk in base calc draw impress math writer printeradmin; do
		mv ${desk}.desktop openoffice.org-2.0-${desk}.desktop
		sed -i -e s/openoffice.org-2.0/ooffice2/g openoffice.org-2.0-${desk}.desktop || die
		sed -i -e s/'Icon=openofficeorg-20-'${desk}/'Icon=openoffice.org-2.0-'${desk}/g openoffice.org-2.0-${desk}.desktop
		domenu openoffice.org-2.0-${desk}.desktop
		cp ${D}/usr/share/icons/hicolor/48x48/apps/openofficeorg-20-${desk}.png ${D}/usr/share/pixmaps/openoffice.org-2.0-${desk}.png
	done

	einfo "Removing build root from registry..."
	# Install wrapper script
	newbin ${FILESDIR}/ooo-wrapper2 ooffice2
	sed -i -e s/PV/${PV}/g ${D}/usr/bin/ooffice2 || die
	sed -i -e "s|INSTDIR|${INSTDIR}|g" ${D}/usr/bin/ooffice2 || die

	# Component symlinks
	for app in base calc draw fromtemplate impress math web writer; do
		dosym ooffice2 /usr/bin/oo${app}2
	done

	dosym ${INSTDIR}/program/spadmin.bin /usr/bin/oopadmin2

	# Change user install dir
	sed -i -e s/.openoffice.org2/.ooo-2.0/g ${D}${INSTDIR}/program/bootstraprc || die

	# Fixing some icon dir permissions
	chmod 755 -R ${D}/usr/share/icons/ || die

	# Icon symlinks for gnome
	dodir /usr/share/pixmaps
	for app in base calc draw impress math printeradmin writer; do
		dosym /usr/share/icons/gnome/32x32/apps/openofficeorg-20-${app}.png /usr/share/pixmaps/openofficeorg-20-${app}.png
	done

	# Non-java weirdness see bug #99366
	use java || rm -f ${D}${INSTDIR}/program/javaldx
}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
}
