# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib flag-o-matic

DESCRIPTION="An open source project that includes YUV scaling and conversion functionality"
HOMEPAGE="https://chromium.googlesource.com/libyuv/libyuv/"

LIBYUV_COMMIT="04821d1e7d60845525e8db55c7bcd41ef5be9406"
SRC_URI="https://gitlab.com/chromiumsrc/libyuv/-/archive/${LIBYUV_COMMIT}/libyuv-${LIBYUV_COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${LIBYUV_COMMIT}"
# Upstream libyuv: https://chromium.googlesource.com/libyuv/libyuv

LICENSE="BSD"
SLOT="0/${PV##*pre}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv"
IUSE=""

# Bundled libs:
RDEPEND="
"
DEPEND="${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
        "${FILESDIR}"/cmake.patch
)


src_unpack() {
	#unpack "${P}.tar.bz2"
	unpack "libyuv-${LIBYUV_COMMIT}.tar.bz2"
}

src_prepare() {
	cp "${FILESDIR}"/libyuv.pc.in "${S}"/ || die

	cmake_src_prepare
}

multilib_src_configure() {
	# Defined by -DCMAKE_BUILD_TYPE=Release, avoids crashes
	# See https://bugs.gentoo.org/754012
	# EAPI 8 still wipes this flag.
	#append-cppflags '-DNDEBUG'

	local mycmakeargs=(
	)
	cmake_src_configure
}

multilib_src_install() {
	cmake_src_install
	#newlib.so "${S}_build/libyuv.so" libyuv.so
	#newlib.a "${S}_build/libyuv.a" libyuv.a
	#newbin "${S}_build/yuvconvert" yuvconvert
	#doheader include/libyuv.h
	#doheader -r include/libyuv

	#local headers=(
	#	third_party/libyuv/include
	#	rtc_base/third_party/sigslot
	#	rtc_base/third_party/base64
	#)
	#for dir in "${headers[@]}"; do
	#	pushd "${S}/src/${dir}" > /dev/null || die
	#	find -type f -name "*.h" -exec install -Dm644 '{}' "${ED}/usr/include/tg_owt/${dir}/{}" \; || die
	#	popd > /dev/null || die
	#done
}
