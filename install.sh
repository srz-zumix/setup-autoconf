#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${AUTOCONF_INSTALLDIR}"

install() {
  echo '::group::📖 Installing autoconf ...'
  cd "${autoconf_TEMPDIR}/autoconf-${VERSION}"
  ./configure --prefix="${AUTOCONF_INSTALLDIR}"
  make -j"$(nproc)"
  make install
  echo '::endgroup::'
}

install

echo "${AUTOCONF_INSTALLDIR}/bin" >> "${GITHUB_PATH:-/dev/null}"
