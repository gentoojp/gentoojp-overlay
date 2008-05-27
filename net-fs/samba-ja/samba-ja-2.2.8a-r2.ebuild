# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

IUSE="pam acl cups ldap ssl tcpd"
# IUSE="${IUSE} oav"

VSCAN_VER=0.3.2
VSCAN_MODS=${VSCAN_MODS:=fprot mks openantivirus sophos trend icap} #kapersky
# To build the "kapersky" plugin, the kapersky lib must be installed.

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://www.samba.gr.jp"
P="samba-2.2.8a-ja-1.1"
S=${WORKDIR}/${P}
SRC_URI="oav? mirror://sourceforge/openantivirus/${PN}-vscan-${VSCAN_VER}.tar.bz2
	http://ftp.ring.gr.jp/pub/net/samba-jp/samba-2.2.8a-ja/samba-2.2.8a-ja-1.1.tar.bz2"

DEPEND="pam? >=sys-libs/pam-0.72
	acl? sys-apps/acl
	cups? net-print/cups
	ldap? =net-nds/openldap-2*
	ssl? >=dev-libs/openssl-0.9.6
	tcpd? >=sys-apps/tcp-wrappers-7.6
	oav? >=dev-libs/popt-1.6.3"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	local i
	unpack ${A} || die
	cd ${S} || die

	if use portldap; then
		cd ${S}/source
		epatch $FILESDIR/nonroot-bind.diff
	fi

	# fix kerberos include file collision..
	# --still an issue? :/
	cd ${S}/source/include
	mv profile.h smbprofile.h
	sed -e "s:profile\.h:smbprofile.h:" includes.h > includes.h.new
	mv includes.h.new includes.h

	# for clean docs packaging sake, make a copy..
	cp -a ${S}/examples ${S}/examples.bin
	# prep the samba-vscan source
	use oav && \
	cp -a ${WORKDIR}/${PN}-vscan-${VSCAN_VER} ${S}/examples.bin/VFS

	# Add a patch for sparc to fix bug #27858
	if [ "${ARCH}" = "sparc" ]
	then
		cd ${S}/source/include
		epatch ${FILESDIR}/samba-2.2.8-statfs.patch
	fi

	# Add a patch for sandbox
	cd ${S}/source
	epatch ${FILESDIR}/samba-2.2.2-buildroot.patch

	cd ${S}/source
	autoconf || die
}

src_compile() {
	local i myconf
	use acl && myconf="--with-acl-support" \
		||  myconf="--without-acl-support"

	use ssl && myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	use pam && myconf="${myconf} --with-pam --with-pam_smbpass" \
		|| myconf="${myconf} --without-pam --without-pam_smbpass"

	use cups && myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"

	use ldap && myconf="${myconf} --with-ldapsam --with-winbind-ldap-hack" \
		|| myconf="${myconf} --without-ldapsam"

	cd ${S}/source
	econf \
		--libdir=/etc/samba \
		--with-fhs \
		--with-piddir=/var/run/samba \
		--with-lockdir=/var/cache/samba \
		--with-swatdir=/usr/share/swat \
		--with-privatedir=/etc/samba/private \
		--with-codepagedir=/usr/share/samba/codepages \
		--with-winbind-auth-challenge \
		--with-sendfile-support \
		--without-smbwrapper \
		--with-automount \
		--without-spinlocks \
		--with-libsmbclient \
		--with-netatalk \
		--with-smbmount \
		--with-profile \
		--with-quotas \
		--with-syslog \
		--with-msdfs \
		--with-utmp \
		--with-i18n-swat \
		--with-mmap \
		--with-vfs \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	# compile samba..
	emake
	emake nsswitch/libnss_wins.so
	assert "samba compile problem"
	if use pam; then
		make nsswitch/pam_winbind.so
		make pam_smbpass || die "pam_smbpass compile problem"
	fi

	# compile the bundled vfs modules..
	cd ${S}/examples.bin/VFS
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man || die "bad ./configure"
	make || die "VFS modules compile problem"

	# compile the selected antivirus vfs plugins..
	if use oav; then
		for i in ${VSCAN_MODS}
		do
			cd ${S}/examples.bin/VFS/${PN}-vscan-${VSCAN_VER}/$i
			make USE_INCLMKSDLIB=1 #needed for the mks build
			assert "problem building $i vscan module"
		done
	fi

	# compile mkntpasswd in examples/LDAP/ for smbldaptools..
	if use ldap; then
		cd ${S}/examples.bin/LDAP/smbldap-tools/mkntpwd
		VISUAL="" make || die "mkntpwd compile problem"
	fi
}

src_install() {
	local i

	pushd source
	einstall \
		BINDIR=${D}/usr/bin \
		BASEDIR=${D}/usr \
		SBINDIR=${D}/usr/sbin \
		DATADIR=${D}/usr/share \
		LOCKDIR=${D}/var/cache/samba \
		PRIVATEDIR=${D}/etc/samba/private \
		LIBDIR=${D}/etc/samba \
		CONFIGDIR=${D}/etc/samba \
		MANDIR=${D}/usr/share/man \
		VARDIR=${D}/var/log/samba \
		PIDDIR=${D}/var/run \
		CODEPAGEDIR=${D}/usr/share/samba/codepages \
		SWATDIR=${D}/usr/share/swat \
		SAMBABOOK=${D}/usr/share/swat/using_samba
	popd

	# make users lives easier..
	fperms 4755 /usr/bin/smbumount
	fperms 4755 /usr/bin/smbmnt

	# some utility scripts..
	for i in mksmbpasswd.sh convert_smbpasswd
	do
		exeinto /usr/bin
		doexe source/script/${i}
	done

	# Install other stuff
	install -m644 packaging/SambaJP/smb.conf ${D}/etc/samba/smb.conf
	install -m600 packaging/SambaJP/smbpasswd ${D}/etc/samba/private/smbpasswd
	install -m644 packaging/SambaJP/smbusers ${D}/etc/samba/private/smbusers
	install -m755 packaging/SambaJP/findsmb ${D}/usr/bin/findsmb
	echo 127.0.0.1 localhost > ${D}/etc/samba/lmhosts
	
	# utilities from LDAP/smbldap-tools
	if use ldap; then
		exeinto /usr/share/samba/smbldap-tools
		doexe examples/LDAP/smbldap-tools/*.pl
		doexe examples/LDAP/smbldap-tools/smbldap_tools.pm
		doexe examples/LDAP/{import,export}_smbpasswd.pl
		chmod 0700 ${D}/usr/share/samba/smbldap-tools/{import,export}_smbpasswd.pl
		exeinto /usr/sbin
		doexe examples.bin/LDAP/smbldap-tools/mkntpwd/mkntpwd
		#dodir /usr/lib/perl5/site_perl/5.6.1
		eval `perl '-V:installarchlib'`
		dodir ${installarchlib}
		dosym /etc/samba/smbldap_conf.pm ${installarchlib}
		dosym /usr/share/samba/smbldap-tools/smbldap_tools.pm ${installarchlib}
	fi


	# libraries..
	exeinto /usr/lib
	#broke
	#doexe source/bin/smbwrapper.so
	doexe source/bin/libsmbclient.so
	insinto /usr/lib
	doins source/bin/libsmbclient.a
	insinto /usr/include
	doins source/include/libsmbclient.h
	exeinto /lib/security
	doexe source/nsswitch/pam_winbind.so
	use pam && doexe source/bin/pam_smbpass.so


	# nsswitch library extension files..
	for i in wins winbind
	do
		exeinto /lib
		doexe source/nsswitch/libnss_${i}.so
	done
	# make link for wins and winbind resolvers..
	( cd ${D}/lib ; ln -s libnss_wins.so libnss_wins.so.2 )
	( cd ${D}/lib ; ln -s libnss_winbind.so libnss_winbind.so.2 )


	# vfs modules..
	exeinto /usr/lib/samba/vfs
	doexe examples.bin/VFS/audit.so
	doexe examples.bin/VFS/block/block.so
	doexe examples.bin/VFS/recycle/recycle.so
	use oav && \
	doexe examples.bin/VFS/${PN}-vscan-${VSCAN_VER}/*/vscan-*.so

	# attempt to install all the docs as easily as possible :/
	# we don't want two copies of the book or manpages
	rm -rf docs/htmldocs/using_samba docs/manpages
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	docinto full_docs
	cp -a docs/* ${D}/usr/share/doc/${PF}/full_docs
	docinto examples
	cp -a examples/* ${D}/usr/share/doc/${PF}/examples
	prepalldocs
	# keep this next line *after* prepalldocs!
	dosym /usr/share/swat/using_samba /usr/share/doc/${PF}/using_samba
	# and we should unzip the html docs..
	gunzip ${D}/usr/share/doc/${PF}/full_docs/faq/*
	gunzip ${D}/usr/share/doc/${PF}/full_docs/htmldocs/*
	if use oav; then
		docinto ${PN}-vscan-${VSCAN_VER}
		cd ${WORKDIR}/${PN}-vscan-${VSCAN_VER}
		dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
		dodoc */*.conf
	fi


	# link /usr/bin/smbmount to /sbin/mount.smbfs which allows it
	# to work transparently with the standard 'mount' command..
	dodir /sbin
	dosym /usr/bin/smbmount /sbin/mount.smbfs


	# make the smb backend symlink for cups printing support..
	if use cups; then
		dodir /usr/lib/cups/backend
		dosym /usr/bin/smbspool /usr/lib/cups/backend/smb
	fi


	# now the config files..
	insinto /etc
	doins ${FILESDIR}/nsswitch.conf-winbind
	doins ${FILESDIR}/nsswitch.conf-wins

	insinto /etc/samba
	doins ${FILESDIR}/smbusers
	doins ${FILESDIR}/smb.conf.example
	doins ${FILESDIR}/lmhosts
	doins ${FILESDIR}/recycle.conf
	if use ldap; then
		doins ${FILESDIR}/smbldap_conf.pm
		doins ${FILESDIR}/samba-slapd-include.conf
	fi

	insinto /etc/pam.d
	newins ${FILESDIR}/samba.pam samba
	doins ${FILESDIR}/system-auth-winbind

	exeinto /etc/init.d
	newexe ${FILESDIR}/samba-init samba
	newexe ${FILESDIR}/winbind-init winbind

	insinto /etc/xinetd.d
	newins ${FILESDIR}/swat.xinetd swat
}

pkg_postinst() {
	# touch /etc/samba/smb.conf so that people installing samba just
	# to mount smb shares don't get annoying warnings all the time..
	if [ ! -e ${ROOT}/etc/samba/smb.conf ] ; then
		touch ${ROOT}/etc/samba/smb.conf
	fi

	# empty dirs..
	install -m0700 -o root -g root -d ${ROOT}/etc/samba/private
	install -m1777 -o root -g root -d ${ROOT}/var/spool/samba
	install -m0755 -o root -g root -d ${ROOT}/var/log/samba
	install -m0755 -o root -g root -d ${ROOT}/var/run/samba
	install -m0755 -o root -g root -d ${ROOT}/var/cache/samba
	install -m0755 -o root -g root -d ${ROOT}/var/lib/samba/{netlogon,profiles}
	install -m0755 -o root -g root -d \
		${ROOT}/var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}
}
