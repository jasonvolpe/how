#!/usr/bin/env bash
#
# installs how
##################################################

set -e

readonly HOW="how"
readonly INSTALL_DIR="how"
readonly INSTALL_ROOT="/usr/local"
readonly INSTALL_ALIAS_PATH="/usr/local/bin"
readonly GIT_URL="https://github.com/jasonvolpe/how.git"
readonly HOW_CONFIG="${HOME}/.how"

function main() {
	local path
	path="${INSTALL_ROOT}/${INSTALL_DIR}"

	echo "installing in ${path}"

	git clone "${GIT_URL}" "${path}"

	ln "${path}/${HOW}" "${INSTALL_ALIAS_PATH}/${HOW}"

	echo "HOW_ROOT=\"${path}\"" > "${HOW_CONFIG}"
}

main "$@"
