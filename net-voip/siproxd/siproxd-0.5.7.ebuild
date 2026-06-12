# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.4.11.ebuild,v 1.7 2004/07/01 22:18:59 eradicator Exp $

IUSE="static"

SRC_URI="mirror://sourceforge/siproxd/${PN}-${PV}.tar.gz"
DESCRIPTION="proxy/masquerading daemon for the SIP protocol"
HOMEPAGE="http://siproxd.sourceforge.net"
LICENSE="GPL-2"
RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/libc
	>=net-libs/libosip-2"

src_compile() {
	local my_conf

	if use static; then
		my_conf=--enable-static
	fi

	econf	--prefix=/usr \
		--disable-dependency-tracking \
		${my_conf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc COPYING AUTHORS ChangeLog doc/FAQ doc/KNOWN_BUGS doc/siproxd_passwd.cfg doc/siproxd.conf.example doc/sample_cfg_x-lite.txt doc/sample_cfg_budgetone.txt doc/RFC3261_compliance.txt INSTALL NEWS README TODO

	exeinto /etc/init.d
	newexe ${FILESDIR}/siproxd.rc siproxd
}
