# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER=1.93.0

inherit cargo meson vala

MY_PV=${PV/_/.}
MY_P=glycin-${MY_PV}

DESCRIPTION="Sandboxed image decoding library"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glycin/"
SRC_URI="
	https://gitlab.gnome.org/GNOME/glycin/-/archive/${MY_PV}/${MY_P}.tar.bz2
	https://github.com/gentoo-crate-dist/glycin/releases/download/${MY_PV}/${MY_P}-crates.tar.xz
"
S=${WORKDIR}/${MY_P}

LICENSE="|| ( LGPL-2.1+ MPL-2.0 )"
# licenses for dependent crates
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions
	Boost-1.0 BSD BSD-2 CC0-1.0 GPL-3+ IJG ISC
	LGPL-2.1+ LGPL-3+ MIT MIT-0 MPL-2.0
	Unicode-3.0 Unlicense ZLIB
"

SLOT="2"
KEYWORDS="~amd64"
IUSE="debug gtk +introspection vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	>=dev-libs/glib-2.68.0:2
	>=sys-libs/libseccomp-2.5.0
	>=media-libs/fontconfig-2.13.0
	~media-libs/glycin-loaders-${PV}:2
	gtk? ( >=gui-libs/gtk-4.16.0:4 )
"
DEPEND="${RDEPEND}"
RDEPEND+="
	sys-apps/bubblewrap
"
BDEPEND="
	>=dev-build/meson-1.2
	introspection? ( dev-libs/gobject-introspection )
	vala? ( $(vala_depend) )
"

QA_FLAGS_IGNORED="
	usr/lib.*/libglycin-2.so.0
	usr/lib.*/libglycin-gtk4-2.so.0
"

src_prepare() {
	default
	use vala && vala_setup
}

src_configure() {
	local emesonargs=(
		-Dprofile=$(usex debug dev release)
		-Dlibglycin=true
		-Dlibglycin-gtk4=$(usex gtk true false)
		-Dintrospection=$(usex introspection true false)
		-Dvapi=$(usex vala true false)
		-Dglycin-loaders=false
		-Dglycin-thumbnailer=false
		-Dtests=false
	)

	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}
