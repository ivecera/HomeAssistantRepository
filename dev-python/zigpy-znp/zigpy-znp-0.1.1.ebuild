# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="A library for zigpy which communicates with TI ZNP radios"
HOMEPAGE="https://github.com/zha-ng/zigpy-znp https://pypi.org/project/zigpy-znp/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DOCS="README.md"

RDEPEND="dev-python/pyserial-asyncio[${PYTHON_USEDEP}]
	>=dev-python/zigpy-0.23.0[${PYTHON_USEDEP}]
	dev-python/async_timeout[${PYTHON_USEDEP}]
	dev-python/voluptuous[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]"
BDEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

src_prepare() {
	sed "s/packages=find_packages(exclude=\[\"\*.tests\"\])/packages=find_packages('src',exclude=['tests','tests.*'])/g" -i setup.py || die
  eapply_user
}

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
