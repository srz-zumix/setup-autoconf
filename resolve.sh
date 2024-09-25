#!/bin/bash
set -euo pipefail

VERSION="${INPUTS_VERSION:-latest}"

versions() {
  curl -sSL ftp://ftp.gnu.org/gnu/autoconf/ | grep -o 'autoconf-[0-9.]*.tar.gz' | grep -o '[0-9.]*[0-9]' | sort -V
}

resolve_version() {
  if [ "${VERSION}" == 'latest' ]; then
    VERSION=$(versions | tail -1)
  else
    VERSION=$(versions | grep "^${VERSION}\$" | tail -1)
  fi
  echo "version=${VERSION}"
}

if [ "${VERSION}" == 'latest' ] || (echo "${VERSION}" | grep '[*]'); then
  echo '::group::📖 Resolve autoconf version ...'
  resolve_version
  echo '::endgroup::'
fi

echo "version=${VERSION}" >> "${GITHUB_OUTPUT:-/dev/null}"

AUTOCONF_TEMPDIR="${INPUTS_AUTOCONF_TEMPDIR:-}"
if [ -z "${AUTOCONF_TEMPDIR}" ]; then
  if [ -n "${RUNNER_TEMP:-}" ]; then
    AUTOCONF_TEMPDIR="${RUNNER_TEMP:-}"
  else
    AUTOCONF_TEMPDIR="$(mktemp -d)"
  fi
fi

AUTOCONF_INSTALLDIR="${RUNNER_TOOL_CACHE:-${AUTOCONF_TEMPDIR}}/autoconf/${VERSION}"

echo "path=${AUTOCONF_INSTALLDIR}" >> "${GITHUB_OUTPUT:-/dev/null}"
