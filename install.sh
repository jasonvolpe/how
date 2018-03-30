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
	local alias_path
	path="${INSTALL_ROOT}/${INSTALL_DIR}"
	alias_path="${INSTALL_ALIAS_PATH}/${HOW}"

	echo "installing in ${path}"

	# Clone how repo
	if [[ $(test -w "${path}") ]]; then
		git clone "${GIT_URL}" "${path}"
	else
		sudo git clone "${GIT_URL}" "${path}"
	fi

	# Create symlink
	if [[ $(test -w "${alias_path}") ]]; then
		ln "${path}/${HOW}" "${alias_path}"
	else
		sudo ln "${path}/${HOW}" "${alias_path}"
	fi

	# Write install path to $HOME/.how
	echo "HOW_ROOT=\"${path}\"" > "${HOW_CONFIG}"
}

main "$@"
