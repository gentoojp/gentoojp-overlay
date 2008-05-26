# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python flag-o-matic cvs

ECVS_SERVER="anoncvs.gnome.org:/cvs/gnome"
ECVS_MODULE="gnome-python/pygtk"

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="gnome opengl"

RDEPEND=">=dev-lang/python-2.2
	>=x11-libs/pango-1
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/atk-1
	>=dev-libs/glib-2.4.0
	gnome? ( >=gnome-base/libglade-2.3.6 )
	opengl? ( virtual/opengl
		dev-python/pyopengl
		>=x11-libs/gtkglarea-1.99 )
	!>=dev-python/pygtk-1.99.13"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4.3
	>=dev-util/pkgconfig-0.14.0"

S="${WORKDIR}/${ECVS_MODULE}"

src_compile() {
	export NOCONFIGURE=1
	./autogen.sh || die

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s /bin/true py-compile

	use hppa && append-flags -ffunction-sections
	econf --enable-thread || die
	# possible problems with parallel builds (#45776)
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL MAPPING NEWS README THREADS TODO
	rm examples/Makefile*
	cp -r examples ${D}/usr/share/doc/${PF}/

	python_version
	mv ${D}/usr/lib/python${PYVER}/site-packages/pygtk.py \
		${D}/usr/lib/python${PYVER}/site-packages/pygtk.py-2.0
	mv ${D}/usr/lib/python${PYVER}/site-packages/pygtk.pth \
		${D}/usr/lib/python${PYVER}/site-packages/pygtk.pth-2.0
}

src_test() {
	cd tests
	make check-local
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/share/pygtk/2.0/codegen /usr/lib/python${PYVER}/site-packages/gtk-2.0
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
	python_mod_compile /usr/lib/python${PYVER}/site-packages/pygtk.py
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/share/pygtk/2.0/codegen
	python_mod_cleanup
	rm -f ${ROOT}/usr/lib/python${PYVER}/site-packages/pygtk.{py,pth}
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
}
