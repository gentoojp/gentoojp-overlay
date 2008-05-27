# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE="aliaschain cnamefix doc fwdzone ipv6 multipleip roundrobin semanticfixi
srvnaptr static selinux"

inherit eutils

DESCRIPTION="Excellent high-performance DNS services"
HOMEPAGE="http://cr.yp.to/djbdns.html"
URL1="http://www.skarnet.org/software/djbdns-fwdzone"
URL2="http://homepages.tesco.net/~J.deBoynePollard/Softwares/djbdns"
SRC_URI="http://cr.yp.to/djbdns/${P}.tar.gz
	fwdzone? ( ${URL1}/djbdns-1.04-fwdzone.patch )
	roundrobin? ( http://www.legend.co.uk/djb/dns/round-robin.patch )
	multipleip? ( http://danp.net/djbdns/dnscache-multiple-ip.patch
	              http://www.ohse.de/uwe/patches/djbdns-1.05-multiip.diff )
	aliaschain? ( ${URL2}/tinydns-alias-chain-truncation.patch )
	semanticfix? ( ${URL2}/tinydns-data-semantic-error.patch )
	cnamefix? ( ${URL2}/dnscache-cname-handling.patch )
	ipv6? ( http://www.fefe.de/dns/djbdns-1.05-test22.diff.bz2 )
	srvnaptr? ( http://mywebpage.netscape.com/guibv/djbdns-1.05-srvnaptr.diff )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc ~alpha ~mips ~hppa"

RDEPEND=">=sys-process/daemontools-0.70
	doc? ( app-doc/djbdns-man )
	sys-apps/ucspi-tcp
	selinux? ( sec-policy/selinux-djbdns )"

src_unpack() {
	unpack ${A}
	cd ${S}

	useq ipv6 && useq cnamefix && \
	eerror "ipv6 cannot currently be used with the cnamefix patch" && \
	exit -1

	useq ipv6 && useq multipleip && \
	eerror "ipv6 cannot currently be used with the multipleip patch" && \
	exit -1

	useq ipv6 && ( useq fwdzone || useq roundrobin ) && \
	eerror "ipv6 cannot currently be used with the fwdzone or " && \
	eerror "roundrobin patch." && \
	eerror && \
	eerror "If you would like to see ipv6 support along with one of " && \
	eerror "those other patches please submit a working patch that " && \
	eerror "combines ipv6 with either fwdzone or roundrobin but not " && \
	eerror "both at the same time, since the latter 2 patches are " && \
	eerror "mutually exclusive according to bug #31238." && exit -1

	useq fwdzone && useq roundrobin && \
	eerror "fwdzone and roundrobin do not work together according " && \
	eerror "to bug #31238" && exit -1

	useq cnamefix && \
		sed s:'\r'::g < ${DISTDIR}/dnscache-cname-handling.patch \
		> ${WORKDIR}/dnscache-cname-handling.patch && \
		epatch ${WORKDIR}/dnscache-cname-handling.patch
	useq aliaschain && \
		epatch ${DISTDIR}/tinydns-alias-chain-truncation.patch
	useq semanticfix && \
		epatch ${DISTDIR}/tinydns-data-semantic-error.patch

	useq fwdzone && epatch ${DISTDIR}/djbdns-1.04-fwdzone.patch
	useq roundrobin && epatch ${DISTDIR}/round-robin.patch
	useq multipleip && \
		epatch ${DISTDIR}/dnscache-multiple-ip.patch && \
		epatch ${DISTDIR}/djbdns-1.05-multiip.diff

	epatch ${FILESDIR}/headtail.patch
	epatch ${FILESDIR}/dnsroots.patch

	useq ipv6 && {
		einfo "At present dnstrace does NOT support IPv6. It will " \
		      "be compiled without IPv6 support."
		cp -a ${S} ${S}-noipv6
		# Careful -- test21 of the ipv6 patch includes the errno patch
		epatch ${WORKDIR}/djbdns-1.05-test21.diff
		cd ${S}-noipv6
		epatch ${FILESDIR}/${PV}-errno.patch
	} || {
		epatch ${FILESDIR}/${PV}-errno.patch
	}

	useq srvnaptr && epatch ${DISTDIR}/djbdns-1.05-srvnaptr.diff
}

src_compile() {
	LDFLAGS=
	useq static && LDFLAGS="-static"
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
	MAKEOPTS="-j1" emake || die "emake failed"

	# If djbdns is compiled with ipv6 support it breaks dnstrace
	# therefore we must compile dnstrace separately without ipv6
	# support.
	if useq ipv6;
	then
		einfo "Compiling dnstrace without ipv6 support"
		cd ${S}-noipv6
		LDFLAGS=
		useq static && LDFLAGS="-static"
		echo "gcc ${CFLAGS}" > conf-cc
		echo "gcc ${LDFLAGS}" > conf-ld
		echo "/usr" > conf-home
		MAKEOPTS="-j1" emake dnstrace || die "emake failed"
	fi
}

src_install() {
	insinto /etc
	doins dnsroots.global
	into /usr
	dobin *-conf dnscache tinydns walldns rbldns pickdns axfrdns \
	      *-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx \
	      dnsfilter random-ip dnsqr dnsq dnstrace dnstracesort

	useq ipv6 && dobin dnsip6 dnsip6q ${S}-noipv6/dnstrace

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION

	dobin ${FILESDIR}/dnscache-setup
	useq fwdzone && cd ${D}${DESTTREE}/bin && \
		epatch ${FILESDIR}/fwdzone-fix.patch
	dobin ${FILESDIR}/tinydns-setup
	dobin ${FILESDIR}/djbdns-setup
}

pkg_postinst() {
	enewgroup nofiles
	enewuser dnscache -1 /bin/false /nonexistent nofiles
	enewuser dnslog -1 /bin/false /nonexistent nofiles
	enewuser tinydns -1 /bin/false /nonexistent nofiles

	einfo "Use (dnscache-setup + tinydns-setup) or djbdns-setup" \
	      "to configure djbdns."
}
