# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

if [ "${PV}" == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/python/${PN}"
	SRC_URI=""
else
	TYPESHED_COMMIT="58ee9c0"
	SRC_URI="https://github.com/python/${PN}/archive/v${PV}.zip -> ${P}.zip
			https://api.github.com/repos/python/typeshed/tarball/${TYPESHED_COMMIT} -> mypy-typeshed-${PV}-${TYPESHED_COMMIT}.tar.gz"
fi

DESCRIPTION="Optional static typing for Python"
HOMEPAGE="http://www.mypy-lang.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/flake8[${PYTHON_USEDEP}]
			>=dev-python/pytest-3.0[${PYTHON_USEDEP}]
			>=dev-python/pytest-xdist-1.18[${PYTHON_USEDEP}]
			>=dev-python/pytest-cov-2.4.0[${PYTHON_USEDEP}]
			>=dev-python/psutil-5.4.0[${PYTHON_USEDEP}]
			>=dev-python/lxml-4.1.1[${PYTHON_USEDEP}]
			>=dev-python/py-1.5.2[${PYTHON_USEDEP}]
			>=dev-python/virtualenv-16.0.0[${PYTHON_USEDEP}] )
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	)
"
CDEPEND="
	!dev-util/stubgen
	>=dev-python/psutil-4[${PYTHON_USEDEP}]
	>=dev-python/typed-ast-1.4.0[${PYTHON_USEDEP}]
	<dev-python/typed-ast-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4[${PYTHON_USEDEP}]
	>=dev-python/mypy_extensions-0.4.3[${PYTHON_USEDEP}]
	<dev-python/mypy_extensions-0.5.0[${PYTHON_USEDEP}]
	"

RDEPEND="${CDEPEND}"

RESTRICT="!test? ( test )"

src_unpack() {
	if [ "${PV}" == "9999" ]; then
		git-r3_src_unpack
	else
		unpack ${A}
		rmdir "${S}/mypy/typeshed"
		mv "${WORKDIR}/python-typeshed-${TYPESHED_COMMIT}" "${S}/mypy/typeshed"
	fi
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	local PYTHONPATH="$(pwd)"

	"${PYTHON}" runtests.py || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )

	distutils-r1_python_install_all
}
