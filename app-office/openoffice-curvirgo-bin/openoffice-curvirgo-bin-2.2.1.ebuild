# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils fdo-mime rpm versionator multilib

IUSE="gnome java kde"

S="${WORKDIR}/RPMS"
DESCRIPTION="The Japanese version of OpenOffice productivity suite built by curvirgo"
RPM_V="9161"
RPM_P=${PV::5}-${RPM_V}
RPM_P_M=${PV::3}-${RPM_V}
SFN="25813"
SRC_URI="mirror://sourceforge.jp/waooo/${SFN}/OOo_${PV}_LinuxX86_install_ja_curvirgo_rpm.tar.bz2"
RESTRICT="nomirror"

HOMEPAGE="http://waooo.sourceforge.jp/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="!app-office/openoffice
	!app-office/openoffice-bin
	|| ( x11-libs/libXaw virtual/x11 )
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	java? ( !amd64? ( >=virtual/jre-1.4.1 )
		amd64? ( app-emulation/emul-linux-x86-java ) )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	x11-libs/startup-notification"

DEPEND="${RDEPEND}
	sys-apps/findutils
	app-admin/eselect-oodict"

PROVIDE="virtual/ooo"

src_unpack() {
	unpack ${A}

	for i in core01 core02 core03 core04 core05 core03u core04u core05u core06 core07 core08 core09 base calc draw impress math writer graphicfilter pyuno emailmerge testtool xsltfilter; do
		rpm_unpack ${S}/openoffice.org-${i}-${RPM_P}.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.org-freedesktop-menus-${RPM_P_M}.noarch.rpm
	use kde && rpm_unpack ${S}/desktop-integration/openoffice.org-suse-menus-${RPM_P_M}.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.org-gnome-integration-${RPM_P}.i586.rpm
	use java && rpm_unpack ${S}/openoffice.org-javafilter-${RPM_P}.i586.rpm
}

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv ${WORKDIR}/opt/openoffice.org2.2/* ${D}${INSTDIR}

	#Menu entries, icons and mime-types
	cd ${D}${INSTDIR}/share/xdg/
	sed -i -e s/'Exec=openoffice.org-2.2-printeradmin'/'Exec=oopadmin2'/g printeradmin.desktop || die

	for desk in base calc draw impress math printeradmin writer; do
		mv ${desk}.desktop openoffice.org-2.2-${desk}.desktop
		sed -i -e s/openoffice.org2.2/ooffice2/g openoffice.org-2.2-${desk}.desktop || die
		sed -i -e s/openofficeorg22-${desk}/ooo-${desk}2/g openoffice.org-2.2-${desk}.desktop || die
		domenu openoffice.org-2.2-${desk}.desktop
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/usr/share/icons/gnome/48x48/apps/openofficeorg22-${desk}.png ooo-${desk}2.png
	done

	insinto /usr/share/mime/packages
	doins ${WORKDIR}/usr/share/mime/packages/openoffice.org.xml

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
	sed -i -e s/.openoffice.org2/.ooo-2.2/g ${D}${INSTDIR}/program/bootstraprc || die

	# Non-java weirdness see bug #99366
	use !java && rm -f ${D}${INSTDIR}/program/javaldx

	# Remove the provided dictionaries, we use our own instead
	rm -f ${D}${INSTDIR}/share/dict/ooo/*

	# prevent revdep-rebuild from attempting to rebuild all the time
	echo "SEARCH_DIRS_MASK\=\"/usr/lib/openoffice /usr/lib32/openoffice\"" >> ${WORKDIR}/50-openoffice-bin
	insinto /etc/revdep-rebuild && doins ${WORKDIR}/50-openoffice-bin
	#insinto /etc/revdep-rebuild && doins ${FILESDIR}/${PV}/50-openoffice-bin

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	eselect oodict update

	[ -x /sbin/chpax ] && [ -e /usr/lib/openoffice/program/soffice.bin ] && chpax -zm /usr/lib/openoffice/program/soffice.bin
	
	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
	einfo
	einfo " Spell checking is now provided through our own myspell-ebuilds, "
	einfo " if you want to use it, please install the correct myspell package "
	einfo " according to your language needs. "
}
