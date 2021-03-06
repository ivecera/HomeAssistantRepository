# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Discover, connect and control Gree based minisplit systems"
HOMEPAGE="https://github.com/cmroche/greeclimate https://pypi.org/project/greeclimate/"

# Pypi source incomplete https://git.edevau.net/onkelbeh/HomeAssistantRepository/issues/187
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/cmroche/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DOCS="README.md"

RDEPEND="~dev-python/netifaces-0.10.9[${PYTHON_USEDEP}]
	~dev-python/pycryptodome-3.9.8[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

# https://git.edevau.net/onkelbeh/HomeAssistantRepository/issues/188
src_prepare() {
	sed -i "s/packages=setuptools.find_packages()/packages=setuptools.find_packages(exclude=['tests'])/g" -i setup.py || die
	eapply_user
}

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
