#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

if [ -f "${AUTOCONF_INSTALLDIR}/bin/autoconf" ]; then
  echo "installed=true"  | tee -a "${GITHUB_OUTPUT:-/dev/null}"
  echo "${AUTOCONF_INSTALLDIR}/bin" >> "${GITHUB_PATH:-/dev/null}"
else
  echo "installed=false" | tee -a "${GITHUB_OUTPUT:-/dev/null}"
fi
