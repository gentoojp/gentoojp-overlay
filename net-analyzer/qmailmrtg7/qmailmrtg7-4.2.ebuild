# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="qmailmrtg7 - sends them to 9 different mrtg graphs, each graph with 4 historical time series."
HOMEPAGE="http://www.inter7.com/?page=qmailmrtg7"
SRC_URI="http://www.inter7.com/qmailmrtg7/qmailmrtg7-4.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="mail-mta/qmail
    net-analyzer/net-snmp"

src_install () {
    dobin qmailmrtg7 ${FILESDIR}/dnscache-status
    dodoc AUTHORS ChangeLog INSTALL FAQ TODO index.html main_index.html qmail.mrtg.cfg
}

pkg_postinst() {
    einfo "Monitoring qmail with net-snmp"
    echo
    einfo "In snmpd.conf:"
    einfo "  extend qmail-message-status /usr/bin/qmailmrtg7 s /var/log/qmail
    einfo "  extend qmail-bytes-transfer /usr/bin/qmailmrtg7 b /var/log/qmail
    einfo "  extend qmail-smtp-concurrency /usr/bin/qmailmrtg7 t /var/log/smtpd
    einfo "  extend qmail-smtp-sessions /usr/bin/qmailmrtg7 a /var/log/smtpd
    einfo "  extend qmail-pop3-concurrency /usr/bin/qmailmrtg7 t /var/log/pop3d
    einfo "  extend qmail-pop3-sessions /usr/bin/qmailmrtg7 a /var/log/pop3d
    einfo "  extend qmail-queue /usr/bin/qmailmrtg7 q /var/qmail/queue
    einfo "  extend qmail-messages /usr/bin/qmailmrtg7 m /var/log/qmail
    einfo "  extend qmail-concurrency /usr/bin/qmailmrtg7 c /var/log/qmail
    echo
    einfo "  extend qmail-virus /usr/bin/qmailmrtg7 C /var/log/clamd
    einfo "  extend qmail-spam /usr/bin/qmailmrtg7 S /var/log/spamd
    echo
    einfo "  extend dnscache /usr/bin/dnscache-stats
    echo
    einfo "Now you can monitor with the following MIBs:"
    einfo "QMail Queue size"
    einfo "  .1.3.6.1.4.1.8072.1.3.2.4.1.2.11.113.109.97.105.108.45.113.117.101.117.101.1"
    einfo "QMail Unprocessed Queue"
    einfo "  .1.3.6.1.4.1.8072.1.3.2.4.1.2.11.113.109.97.105.108.45.113.117.101.117.101.2"
    einfo "QMail SMTPd Connections"
    einfo "  .1.3.6.1.4.1.8072.1.3.2.4.1.2.22.113.109.97.105.108.45.115.109.116.112.45.99.111.110.99.117.114.114.101.110.99.121.1"
    einfo "djbdns queries"
    einfo "  .1.3.6.1.4.1.8072.1.3.2.4.1.2.8.100.110.115.99.97.99.104.101.1"
}
