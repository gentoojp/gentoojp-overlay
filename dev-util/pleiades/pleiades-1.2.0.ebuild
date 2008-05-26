# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eclipse-ext

DESCRIPTION="Pleiades is an Eclipse plugin for localizing Eclipse plugins into Japanese"
HOMEPAGE="http://mergedoc.sourceforge.jp/"
SFN="26108"
SRC_URI="mirror://sourceforge.jp/mergedoc/${SFN}/${PN}_${PV}.zip"
RESTRICT="nomirror"
SLOT="3.2"
LICENSE="EPL-1.0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.2"
known_eclipse_slots="3.2"

src_install () {
	eclipse-ext_require-slot ${SLOT} || die "Failed to find suitable Eclipse installation"
	eclipse-ext_create-ext-layout binary || die "Failed to create layout"
	eclipse-ext_install-features ${WORKDIR}/features/* || die "Failed to install features"
	eclipse-ext_install-plugins ${WORKDIR}/plugins/* || die "Failed to install plugins"
	
	LOG_DIR="${eclipse_ext_basedir}/configuration/jp.sourceforge.mergedoc.pleiades"
	echo "" > ${WORKDIR}/${PN}.log
	insinto ${LOG_DIR}
	doins ${WORKDIR}/${PN}.log
}

pkg_postinst() {
	chmod 774 ${ROOT}/${LOG_DIR}/${PN}.log
	chgrp users ${ROOT}/${LOG_DIR}/${PN}.log
	
	JAR_PATH="-javaagent:${eclipse_ext_basedir}/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar"
	if [ -z `grep ${PN} ${eclipse_ext_platformdir}/eclipse.ini` ] ; then
		einfo ""
		einfo "Now setting up ${eclipse_ext_platformdir}/eclipse.ini..."
		einfo ""
		echo "${JAR_PATH}" >> ${ROOT}/${eclipse_ext_platformdir}/eclipse.ini
	else
		ewarn ""
		ewarn "It seems that you have already set up ${eclipse_ext_platformdir}/eclipse.ini."
		ewarn "In that case, you must manually add the following line to eclipse.ini:"
		ewarn ""
		ewarn "${JAR_PATH}"
		ewarn ""
	fi
}

pkg_postrm() {
	eclipse-ext_require-slot ${SLOT} || die "Failed to find suitable Eclipse installation"
	eclipse-ext_create-ext-layout binary
	JAR_NAME=${PN}.jar
	sed -i -e '/'$JAR_NAME'/d' ${ROOT}/${eclipse_ext_platformdir}/eclipse.ini || die "sed failed to setup eclipse.ini"
	einfo ""
	einfo "All of lines including the word \"${JAR_NAME}\" was completely deleted"
	einfo "from ${eclipse_ext_platformdir}/eclipse.ini."
	einfo ""
}
