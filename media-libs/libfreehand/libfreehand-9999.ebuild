# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="git://anongit.freedesktop.org/git/libreoffice/libfreehand/"
[[ ${PV} == 9999 ]] && inherit autotools git-r3

DESCRIPTION="Library for import of FreeHand drawings"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libfreehand"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc static-libs"

RDEPEND="
	dev-libs/librevenge
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	dev-libs/icu:=
	dev-util/gperf
	media-libs/lcms
	sys-devel/libtool
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_prepare() {
	default
	[[ -d m4 ]] || mkdir "m4"
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_with doc docs) \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
