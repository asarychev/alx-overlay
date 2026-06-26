# Copyright 2016 Chris Oboe
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit systemd

DESCRIPTION="KMS Emulator in C"
HOMEPAGE="https://github.com/Wind4/vlmcsd"
SRC_URI="https://github.com/Wind4/vlmcsd/archive/svn${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-user/vlmcsd"

DEPEND="${RDEPEND}
	sys-devel/make"

S="${WORKDIR}/${PN}-svn${PV}"

src_compile() {
	emake
	emake man
}

src_install() {
	dosbin ./bin/vlmcsd
	dobin ./bin/vlmcs
	systemd_dounit "${FILESDIR}"/${PN}.service

	doman ./man/vlmcs.1
	doman ./man/vlmcsd.ini.5
	doman ./man/vlmcsd.7
	doman ./man/vlmcsd.8
}
