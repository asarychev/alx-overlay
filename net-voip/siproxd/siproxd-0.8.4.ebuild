# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

IUSE="static"

MY_PV=rel_$(ver_rs 1- _)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Siproxd - a masquerading SIP proxy"
HOMEPAGE="http://siproxd.sourceforge.net/"
SRC_URI="https://github.com/hb9xar/siproxd/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x64 ~arm64"

RESTRICT="test"

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

	dodir /var/run/siproxd
	dodir /var/lib/siproxd

	dodoc COPYING AUTHORS ChangeLog doc/FAQ doc/KNOWN_BUGS doc/siproxd_passwd.cfg doc/siproxd.conf.example doc/sample_cfg_x-lite.txt doc/sample_cfg_budgetone.txt doc/RFC3261_compliance.txt INSTALL NEWS README TODO

	exeinto /etc/init.d
	newexe ${FILESDIR}/siproxd.rc siproxd
}



pkg_postinst() {
	enewgroup siproxd
	enewuser siproxd -1 /bin/false /var/lib/siproxd siproxd

	chown siproxd:siproxd ${ROOT}/var/run/siproxd ${ROOT}/var/lib/siproxd
	chmod 0755 ${ROOT}/var/run/siproxd
	chmod 0700 ${ROOT}/var/lib/siproxd


	einfo "                                                                    "
	einfo " Don't forget to set 'siproxd' as user in /etc/siproxd.conf "
	einfo "                                                                    "
}
