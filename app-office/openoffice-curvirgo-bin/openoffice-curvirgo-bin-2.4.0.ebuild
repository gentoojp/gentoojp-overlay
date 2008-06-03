# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils fdo-mime rpm multilib

IUSE="gnome java kde"

BUILDID="9286"
RPM_PV=${PV}-${BUILDID}
RPM_PV2=${PV%.*}-${BUILDID}

DESCRIPTION="The Japanese version of OpenOffice productivity suite built by curvirgo"
HOMEPAGE="http://waooo.sourceforge.jp/
	http://www.openoffice.org"
SRC_URI="mirror://sourceforge.jp/waooo/30235/OOo_${PV}_LinuxX86_install_ja_curvirgo_rpm.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="!app-office/openoffice
	!app-office/openoffice-bin
	x11-libs/libXaw
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	>=media-libs/freetype-2.1.10-r2
	>=app-admin/eselect-oodict-20060706
	java? ( !amd64? ( >=virtual/jre-1.4 )
		amd64? ( app-emulation/emul-linux-x86-java ) )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	x11-libs/startup-notification"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"
RESTRICT="strip nomirror"

QA_EXECSTACK="usr/$(get_libdir)/openoffice/program/*"
QA_TEXTRELS="usr/$(get_libdir)/openoffice/program/libvclplug_gen680li.so.1.1 \
	usr/$(get_libdir)/openoffice/program/python-core-2.3.4/lib/lib-dynload/_curses_panel.so \
	usr/$(get_libdir)/openoffice/program/python-core-2.3.4/lib/lib-dynload/_curses.so"

S="${WORKDIR}/RPMS"

src_unpack() {

	unpack ${A}

	for i in base calc core01 core02 core03 core03u core04 core04u core05 core05u core06 core07 core08 core09 core10 draw emailmerge graphicfilter headless impress math pyuno testtool writer xsltfilter; do
		rpm_unpack "${S}/openoffice.org-${i}-${RPM_PV}.i586.rpm"
	done

	rpm_unpack "${S}/desktop-integration/openoffice.org-freedesktop-menus-${RPM_PV2}.noarch.rpm"

	use gnome && rpm_unpack "${S}/openoffice.org-gnome-integration-${RPM_PV}.i586.rpm"
	use kde && rpm_unpack "${S}/desktop-integration/openoffice.org-suse-menus-${RPM_PV2}.noarch.rpm"
	use java && rpm_unpack "${S}/openoffice.org-javafilter-${RPM_PV}.i586.rpm"
}

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv "${WORKDIR}"/opt/openoffice.org2.4/* "${D}${INSTDIR}"

	#Menu entries, icons and mime-types
	cd "${D}${INSTDIR}/share/xdg/"

	for desk in base calc draw impress math printeradmin writer; do
		mv ${desk}.desktop openoffice.org-2.4-${desk}.desktop
		sed -i -e s/openoffice.org2.4/ooffice/g openoffice.org-2.4-${desk}.desktop || die
		sed -i -e s/openofficeorg24-${desk}/ooo-${desk}/g openoffice.org-2.4-${desk}.desktop || die
		domenu openoffice.org-2.4-${desk}.desktop
		insinto /usr/share/pixmaps
		newins "${WORKDIR}/usr/share/icons/gnome/48x48/apps/openofficeorg24-${desk}.png" ooo-${desk}.png
	done

	insinto /usr/share/mime/packages
	doins "${WORKDIR}/usr/share/mime/packages/openoffice.org.xml"

	# Install wrapper script
	newbin "${FILESDIR}/wrapper.in" ooffice
	sed -i -e s/LIBDIR/$(get_libdir)/g "${D}/usr/bin/ooffice" || die

	# Component symlinks
	for app in base calc draw impress math writer; do
		dosym ${INSTDIR}/program/s${app} /usr/bin/oo${app}
	done

	dosym ${INSTDIR}/program/spadmin.bin /usr/bin/ooffice-printeradmin
	dosym ${INSTDIR}/program/soffice /usr/bin/soffice

	# Change user install dir
	sed -i -e s/.openoffice.org2/.ooo-2.0/g "${D}${INSTDIR}/program/bootstraprc" || die

	# Non-java weirdness see bug #99366
	use !java && rm -f "${D}${INSTDIR}/program/javaldx"

	# Remove the provided dictionaries, we use our own instead
	rm -f "${D}"${INSTDIR}/share/dict/ooo/*

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${FILESDIR}/50-openoffice-bin"
}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	eselect oodict update --libdir $(get_libdir)

	[[ -x /sbin/chpax ]] && [[ -e /usr/$(get_libdir)/openoffice/program/soffice.bin ]] && chpax -zm /usr/$(get_libdir)/openoffice/program/soffice.bin

	elog " To start OpenOffice.org, run:"
	elog
	elog " $ ooffice"
	elog
	elog " Also, for individual components, you can use any of:"
	elog
	elog " oobase, oocalc, oodraw, ooimpress, oomath, or oowriter"
	elog
	elog " Spell checking is now provided through our own myspell-ebuilds, "
	elog " if you want to use it, please install the correct myspell package "
	elog " according to your language needs. "
}
