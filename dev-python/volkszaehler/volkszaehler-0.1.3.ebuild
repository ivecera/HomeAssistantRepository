# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="Python Wrapper for interacting with the Volkszahler API."
HOMEPAGE="https://github.com/fabaff/python-volkszaehler https://pypi.org/project/volkszaehler/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
MY_PN=python-${PN}
SRC_URI="https://github.com/home-assistant-ecosystem/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${MY_PN}-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/async_timeout[${PYTHON_USEDEP}]"
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
