#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${AUTOCONF_INSTALLDIR}"

download() {
  echo '::group::📖 Download autoconf ...'
  curl --output "${AUTOCONF_TEMPDIR}/autoconf.tar.gz" -sSL "http://ftpmirror.gnu.org/autoconf/autoconf-${VERSION}.tar.gz"
  curl --output "${AUTOCONF_TEMPDIR}/autoconf.tar.gz.sig" -sSL "http://ftpmirror.gnu.org/autoconf/autoconf-${VERSION}.tar.gz.sig"
  curl --output "${AUTOCONF_TEMPDIR}/gnu-keyring.gpg" -sSL "https://ftp.gnu.org/gnu/gnu-keyring.gpg"
  echo '::endgroup::'
  echo '::group::📖 gpg key import ...'
  gpg --import "${AUTOCONF_TEMPDIR}/gnu-keyring.gpg"
  echo '::endgroup::'
  echo '::group::📖 Unarchive autoconf ...'
  gpg --verify "${AUTOCONF_TEMPDIR}/autoconf.tar.gz.sig" "${AUTOCONF_TEMPDIR}/autoconf.tar.gz"
  tar -zx -f "${AUTOCONF_TEMPDIR}/autoconf.tar.gz" -C "${AUTOCONF_TEMPDIR}/"
  echo '::endgroup::'
}

download
