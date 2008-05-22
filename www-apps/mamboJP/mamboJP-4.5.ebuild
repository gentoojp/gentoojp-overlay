# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mambo/mambo-4.5.ebuild,v 1.3 2004/09/22 08:15:20 rl03 Exp $

inherit webapp

DESCRIPTION="Mambo is yet another CMS"
SRC_URI="http://mamboforge.net/frs/download.php/399/MOSJP-7.zip"
HOMEPAGE="http://mambo.mu-fan.com/"

LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}

IUSE=""

RDEPEND="dev-db/mysql
	>=virtual/php-4.1
	net-www/apache"

pkg_setup () {
	webapp_pkg_setup
	einfo "Please make sure that your PHP is compiled with zlib, XML, and MySQL support"
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components components images media language modules templates uploadfiles"

	dodoc documentation/Changelog-4.5 INSTALL
	dohtml documentation/Install.html

	cp -R [^d]* ${D}/${MY_HTDOCSDIR}

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

pkg_postinst () {
	einfo "Now run ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to setup the database"
	einfo "Note that db and dbuser need to be present prior to running db setup"
}

pkg_config() {
	# default values for db stuff
	D_DB="mambo"
	D_HOST="localhost"
	D_USER="mambo"

	# do we want to start mysqld?
	/etc/init.d/mysql restart || die "mysql needs to be running"

	echo -n "mysql db name [${D_DB}]: "; read MY_DB
	if (test -z ${MY_DB}) ; then MY_DB=${D_DB} ; fi

	echo -n "mysql db host [${D_HOST}]: "; read MY_HOST
	if (test -z ${MY_HOST}) ; then MY_HOST=${D_HOST}; fi

	echo -n "mysql dbuser name [${D_USER}]: "; read MY_USER
	if (test -z ${MY_USER}) ; then MY_USER=${D_USER} ; fi

	echo -n "mysql dbuser password: "; read mypwd
	if (test -z ${mypwd}) ; then die "Error: no dbuser password" ; fi

	# privileges
	echo -n "Please enter login info for user who has grant privileges on ${MY_HOST} [$USER]: "; read adminuser
	if (test -z ${adminuser}) ; then adminuser="$USER" ; fi
	if [ "${MY_HOST}" != "localhost" ]; then
		echo -n "Client address (at db side) [$(hostname -f)]: "; read clientaddr
		if (test -z ${clientaddr}) ; then clientaddr="$(hostname -f)" ; fi
	fi
	# this will be default for localhost
	if (test -z ${clientaddr}) ; then clientaddr="${MY_HOST}" ; fi

	# if $MY_HOST == localhost, don't specify -h argument, so local socket can be used.
	host=${MY_HOST/localhost}
	mysqladmin -u ${MY_USER} ${host:+-h ${host}} -p create ${MY_DB} || die "Error creating database"
	mysql -u ${adminuser} ${host:+-h ${host}} -p mysql --exec="GRANT SELECT,INSERT,UPDATE,DELETE,INDEX, ALTER,CREATE,DROP,REFERENCES ON ${MY_DB}.* TO ${MY_USER}@${clientaddr} IDENTIFIED BY '${mypwd}'; FLUSH PRIVILEGES;"  || {
	echo "Error running query!"
	echo
	echo "Please run it manually on ${host}."
	echo
	echo "   \$ mysql -u ${adminuser} -p mysql --exec=\"GRANT SELECT,INSERT,UPDATE,DELETE,INDEX, ALTER,CREATE,DROP,REFERENCES ON ${MY_DB}.* TO ${MY_USER}@${clientaddr} IDENTIFIED BY '${mypwd}'; FLUSH PRIVILEGES;\""
	echo
	}
}
