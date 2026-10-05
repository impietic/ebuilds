# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Just when you wonder how minimal could it get.. but usable.. and GNOME."
HOMEPAGE="https://www.gnome.org/"

S="${WORKDIR}"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+gnome-shell"

RDEPEND="
	>=gnome-base/gnome-core-libs-51.0
	>=gnome-base/gnome-session-51.0
	>=gnome-base/gnome-settings-daemon-51.0
	>=gnome-base/gnome-control-center-51.0
	>=gnome-base/gdm-51.0
	app-crypt/oo7

	gnome-shell? (
		>=x11-wm/mutter-51.0
		>=gnome-base/gnome-shell-51.0
		>=media-fonts/adwaita-fonts-51.0
	)

	>=x11-themes/adwaita-icon-theme-51.0
"

pkg_postinst() {
	elog "Obligatory message but please remember to look at https://wiki.gentoo.org/wiki/Project:GNOME"
	elog "for information about the project and documentation."
}
