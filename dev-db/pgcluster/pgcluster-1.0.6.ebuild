# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The multi-master and synchronous replication system for PostgreSQL"

OPV="7.3.4"
P_HIERPG="hier-Pg7.3-0.3"
HOMEPAGE="http://www.csra.co.jp/~mitani/jpug/pgcluster/"
SRC_URI="http://www.csra.co.jp/~mitani/jpug/pgcluster/stable/${P}.tar.gz
	pg-hier? ( http://gppl.terminal.ru/${P_HIERPG}.tar.gz )"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl nls java python tcltk perl libg++ pam readline zlib pg-hier cluster pgreplicate pglb"

DEPEND="virtual/glibc
	sys-devel/autoconf
	app-admin/sudo
	>=sys-libs/ncurses-5.2
	zlib? ( >=sys-libs/zlib-1.1.3 )
	readline? ( >=sys-libs/readline-4.1 )
	tcltk? ( >=dev-lang/tcl-8 >=dev-lang/tk-8.3.3-r1 )
	perl? ( >=dev-lang/perl-5.6.1-r2 )
	python? ( !ppc? ( >=dev-lang/python-2.2 dev-python/egenix-mx-base ) )
	java? ( !amd64? ( >=virtual/jdk-1.3* >=dev-java/ant-1.3
		dev-java/java-config ) )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	nls? ( sys-devel/gettext )"
# java dep workaround for portage bug
# x86? ( java? ( =dev-java/sun-jdk-1.3* >=dev-java/ant-1.3 ) )
RDEPEND="virtual/glibc
	zlib? ( >=sys-libs/zlib-1.1.3 )
	tcltk? ( >=dev-lang/tcl-8 )
	perl? ( >=dev-lang/perl-5.6.1-r2 )
	python? ( !ppc? ( >=dev-lang/python-2.2 ) )
	java? ( !amd64? ( >=virtual/jdk-1.3* ) )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )"

PG_DIR="/var/lib/postgresql"

PROVIDE="dev-db/postgresql"

pkg_setup() {
	if [ -f ${PG_DIR}/data/PG_VERSION ] ; then
		PG_MAJOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f1 -d.`
		PG_MINOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f2 -d.`
		if [ ${PG_MAJOR} -lt 7 ] || [ ${PG_MAJOR} -eq 7 -a ${PG_MINOR} -lt 3 ] ; then
			eerror "Postgres ${OPV} cannot upgrade your existing databases, you must"
			eerror "use pg_dump to export your existing databases to a file, and then"
			eerror "pg_restore to import them when you have upgraded completely."
			eerror "You must remove your entire database directory to continue."
			eerror "(database directory = ${PG_DIR})."
			die
		fi
	fi

	if [ "`use java`" ]; then
		if [ "`use amd64`" -o "`use hppa`" ]; then
			ewarn "Ignored USE=\"java\" in amd64/hppa"
		fi
	fi

	if [ "`use python`" ]; then
		if [ "`use ppc`" ]; then
			ewarn "Ignore USE=\"python\" in ppc"
		fi
	fi
}

check_java_config() {
	JDKHOME="`java-config --jdk-home`"
	if [ -z "${JDKHOME}" ] || [ ! -d "${JDKHOME}" ]; then
		NOJDKERROR="You need to use java-config to set your JVM to a JDK!"
		eerror "${NOJDKERROR}"
		die "${NOJDKERROR}"
	fi
}

src_unpack() {
	unpack ${A} || die
	if [ "`use pg-hier`" ]; then
		cd ${WORKDIR} || die
		mv readme.html README-${P_HIERPG}.html || die
		cd ${S} || die
		epatch ${WORKDIR}/hier-Pg7.3.1-0.3.diff || die
	fi
	cd ${S} || die
}

src_compile() {
	filter-flags -ffast-math

	if [ "`use java`" -a ! "`use amd64`" -a ! "`use hppa`" ]; then
		check_java_config
	fi

	local myconf
	use tcltk && myconf="--with-tcl"
	use python && use ppc || myconf="$myconf --with-python"
	use perl && myconf="$myconf --with-perl"
	if [ "`use java`" -a ! "`use amd64`" -a ! "`use hppa`" ]; then
		myconf="$myconf --with-java"
	fi
	use ssl && myconf="$myconf --with-openssl"
	use nls && myconf="$myconf --enable-nls"
	use libg++ && myconf="$myconf --with-CXX"
	use pam && myconf="$myconf --with-pam"
	use readline || myconf="$myconf --without-readline"
	use zlib || myconf="$myconf --without-zlib"

	# these are the only working CFLAGS I could get on ppc, so locking them
	# down, anything more aggressive fails (i.e. -mcpu or -Ox)
	# Gerk - Nov 26, 2002
	use ppc && CFLAGS="-pipe -fsigned-char"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--docdir=/usr/share/doc/${P} \
		--libdir=/usr/lib \
		--enable-depend \
		--with-gnu-ld \
		--with-maxbackends=1024 \
		$myconf || die

	make || die
	cd contrib
	make || die

	if [ `use pgreplicate` ]
	then
		cd ${S}/src/pgcluster/pgrp
		sed -i -e 's:/usr/local/pgsql:/usr:g' Makefile* || die
		econf || die
		emake || die
	fi
	if [ `use pglb` ]
	then
		cd ${S}/src/pgcluster/pglb
		sed -i -e 's:/usr/local/pgsql:/usr:g' Makefile* || die
		econf || die
		emake || die
	fi
}

src_install() {
	addwrite "/usr/share/man/man3/Pg.3pm"

	if [ `use cluster` ] || [ ! `use pgreplicate` -a ! `use pglb` ]
	then
		if [ "`use perl`" ]
		then
			mv ${S}/src/pl/plperl/Makefile ${S}/src/pl/plperl/Makefile_orig
			sed -e "s:(INST_DYNAMIC) /usr/lib:(INST_DYNAMIC) ${D}/usr/lib:" \
				${S}/src/pl/plperl/Makefile_orig > ${S}/src/pl/plperl/Makefile
			mv ${S}/src/pl/plperl/GNUmakefile ${S}/src/pl/plperl/GNUmakefile_orig
			sed -e "s:\$(DESTDIR)\$(plperl_installdir):\$(plperl_installdir):" \
				${S}/src/pl/plperl/GNUmakefile_orig > ${S}/src/pl/plperl/GNUmakefile
		fi

		make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die
		make DESTDIR=${D} install-all-headers || die
		cd ${S}/contrib
		make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die
		cd ${S}
		if [ "`use pg-hier`" ]; then
			dodoc ${WORKDIR}/README-${P_HIERPG}.html
		fi
		dodoc COPYRIGHT HISTORY INSTALL* README* register.txt
		dodoc contrib/adddepend/*
		cd ${S}/doc
		dodoc FAQ* KNOWN_BUGS MISSING_FEATURES README*
		dodoc TODO bug.template
		docinto sgml
		dodoc src/sgml/*.{sgml,dsl}
		docinto sgml/ref
		dodoc src/sgml/ref/*.sgml
		docinto sgml/graphics
		dodoc src/graphics/*
		rm -rf ${D}/usr/doc ${D}/mnt
		exeinto /usr/bin

		if [ "`use java`" -a ! "`use amd64`" -a ! "`use hppa`" ]; then
			dojar ${D}/usr/share/postgresql/java/postgresql.jar
			rm ${D}/usr/share/postgresql/java/postgresql.jar
		fi

		dodir /usr/include/postgresql/pgsql
		cp ${D}/usr/include/*.h ${D}/usr/include/postgresql/pgsql

		exeinto /etc/init.d/
		newexe ${FILESDIR}/pgcluster.init pgcluster || die

		insinto /etc/conf.d/
		newins ${FILESDIR}/pgcluster.conf pgcluster || die
	fi
	if [ `use pgreplicate` ]
	then
		cd ${S}/src/pgcluster/pgrp
		make DESTDIR=${D} install || die

		docinto pgreplicate
		dodoc ChangeLog INSTALL NEWS README

		exeinto /etc/init.d/
		newexe ${FILESDIR}/pgreplicate.init pgreplicate || die
	fi
	if [ `use pglb` ]
	then
		cd ${S}/src/pgcluster/pglb
		make DESTDIR=${D} install || die

		docinto pglb
		dodoc ChangeLog INSTALL NEWS README

		exeinto /etc/init.d/
		newexe ${FILESDIR}/pglb.init pglb || die
	fi
}

pkg_postinst() {

	if [ `use cluster` ] || [ ! `use pgreplicate` -a ! `use pglb` ]
	then
		einfo "Execute the following command"
		einfo "ebuild  /var/db/pkg/dev-db/${PF}/${PF}.ebuild config"
		einfo "to setup the initial database environment."
		einfo ""
		einfo "Make sure the postgres user in /etc/passwd has an account setup with /bin/bash as the shell, or /bin/true"
	fi
}

pkg_config() {
	einfo "Creating the data directory ..."
	mkdir -p ${PG_DIR}/data
	chown -Rf postgres:postgres ${PG_DIR}
	chmod 700 ${PG_DIR}/data

	einfo "Initializing the database ..."
	if [ -f ${PG_DIR}/data/PG_VERSION ] ; then
		PG_MAJOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f1 -d.`
		PG_MINOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f2 -d.`
		if [ ${PG_MAJOR} -lt 7 ] || [ ${PG_MAJOR} -eq 7 -a ${PG_MINOR} -lt 3 ] ; then
			eerror "Postgres ${OPV} cannot upgrade your existing databases."
			eerror "You must remove your entire database directory to continue."
			eerror "(database directory = ${PG_DIR})."
			die
		else
			einfon "A postgres data directory already exists from version "; cat ${PG_DIR}/data/PG_VERSION
			einfo "Read the documentation to check how to upgrade to version ${PV}."
		fi
	else
		# On hppa, postgresql need way more than the default sem index and shmmax
		if [ "${ARCH}" = "hppa" ]; then
			SEM_IDX_MIN=1024
			SHMMAX_MIN=100000000
			SEM_IDX=`sysctl kernel.sem | awk '{ print $6 }'`
			if [ $SEM_IDX -lt ${SEM_IDX_MIN} ]; then
				eerror "The last value of /proc/sys/kernel/sem is too low for postgresql to run"
				eerror "Temporary setting this value to ${SEM_IDX_MIN} while creating the initial database."
				cat /proc/sys/kernel/sem | sed -e "s/\t${SEM_IDX}/\t${SEM_IDX_MIN}/" > /proc/sys/kernel/sem
			fi
		fi
		sudo -u postgres /usr/bin/initdb --pgdata ${PG_DIR}/data

		if [ "${ARCH}" = "hppa" ]; then
			if [ ! `sysctl kernel.sem | awk '{ print $6 }'` -eq ${SEM_IDX} ] ; then
				cat /proc/sys/kernel/sem | sed -e "s/\t${SEM_IDX_MIN}/\t${SEM_IDX}/" > /proc/sys/kernel/sem
				ewarn "Restoring the sem idx value to the previous value"
				ewarn "Please edit the last value of kernel.sem in /etc/sysctl.conf"
				ewarn "and set it to at least ${SEM_IDX_MIN}"
			fi

			if [ `sysctl kernel.shmmax | awk '{ print $3 }'` -lt ${SHMMAX_MIN} ]; then
				eerror "The current value of /proc/sys/kernel/shmmax is too low"
				eerror "for postgresql to run. Please edit /etc/sysctl.conf and set"
				eerror "this value to at least ${SHMMAX_MIN}."

			fi
		fi

		einfo "If you are upgrading from a pre-7.3 version of PostgreSQL, please read"
		einfo "the README.adddepend file for information on how to properly migrate"
		einfo "all serial columns, unique keys and foreign keys to this version."
	fi
}
