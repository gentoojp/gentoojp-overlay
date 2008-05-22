#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: $

checkbin() {
	if [ ! -x /usr/sbin/wxgserver ] ; then
		eerror "WXG server not found."
		eerror "Something might be broken in WXG installation."
		return 1
	fi
	if [ ! -x /usr/sbin/cannakill ] ; then
		eerror "Cannakill utility not found."
		eerror "You must install app-i18n/canna to run this script."
		return 1
	fi
}

start() {
	checkbin || return 1
	if [ -S /tmp/.iroha_unix/IROHA ] ; then
		/usr/sbin/cannakill >/dev/null 2>&1
	fi
	rm -f /tmp/.iroha_unix/IROHA

	ebegin "Starting WXG"
	/usr/sbin/wxgserver &
	eend $?
}

stop() {
	ebegin "Stopping WXG"
	/usr/bin/cannakill
	eend $?
}
