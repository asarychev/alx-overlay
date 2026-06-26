# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

SRC_URI="https://github.com/AlynxZhou/showmethekey/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Show keys you typed on screen"
HOMEPAGE="https://showmethekey.alynx.one/ https://github.com/AlynxZhou/showmethekey"
LICENSE="Apache-2.0"
SLOT="0"

IUSE=""

RDEPEND="
	gui-libs/gtk:4[wayland]
	gui-libs/libadwaita:1
	dev-util/gtk-update-icon-cache
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	# Nothing should use gtk4-update-icon-cache and an unversioned one is shipped by dev-util/gtk-update-icon-cache
	sed -i \
		-e 's/gtk4-update-icon-cache/gtk-update-icon-cache/g' \
		meson.build \
		|| die
}

src_configure() {
	meson_src_configure
}
