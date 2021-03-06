# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="https://python-requests.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64 x86 amd64-linux x86-linux"
IUSE="socks5 +ssl"

RDEPEND="
	>=dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/chardet-3.0.2[${PYTHON_USEDEP}]
	<dev-python/chardet-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/idna-2.5[${PYTHON_USEDEP}]
	<dev-python/idna-2.9[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.21.1[${PYTHON_USEDEP}]
	<dev-python/urllib3-1.26[${PYTHON_USEDEP}]
	!~dev-python/urllib3-1.25.0[${PYTHON_USEDEP}]
	!~dev-python/urllib3-1.25.1[${PYTHON_USEDEP}]
	socks5? ( >=dev-python/PySocks-1.5.6[${PYTHON_USEDEP}] )
	ssl? (
		>=dev-python/cryptography-1.3.4[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-0.14[$(python_gen_usedep 'python*' pypy)]
	)
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

# tests connect to various remote sites
RESTRICT="test"

#DEPEND+="
#	test? (
#		dev-python/pytest[${PYTHON_USEDEP}]
#		dev-python/pytest-httpbin[${PYTHON_USEDEP}]
#		dev-python/pytest-mock[${PYTHON_USEDEP}]
#		dev-python/pytest-xdist[${PYTHON_USEDEP}]
#		>=dev-python/PySocks-1.5.6[${PYTHON_USEDEP}]
#	)
#"

python_test() {
	py.test || die
}
