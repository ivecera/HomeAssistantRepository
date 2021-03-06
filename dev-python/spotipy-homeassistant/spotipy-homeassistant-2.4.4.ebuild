# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="simple client for the Spotify Web API"
HOMEPAGE="https://github.com/plamere/spotipy https://spotipy.readthedocs.org/ https://pypi.org/project/spotipy-homeassistant/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.dev1.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${PV}.dev1

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=">=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.3.0[${PYTHON_USEDEP}]"
DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
