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

# param 1: path of source repo (optional)
function main() {
	local path
	local alias_path
	local repo

	path="${INSTALL_ROOT}/${INSTALL_DIR}"
	alias_path="${INSTALL_ALIAS_PATH}/${HOW}"
	repo="${1:-$GIT_URL}"

	echo "Installing in ${path} from ${repo}"

	# Clone how repo
	if [[ $(test -w "${path}") ]]; then
		git clone "${repo}" "${path}"
	fi

	# Create symlink
	if [[ $(test -w "${alias_path}") ]]; then
		ln "${path}/${HOW}" "${alias_path}"
	fi

	# Write install path to $HOME/.how
	echo "HOW_ROOT=\"${path}\"" > "${HOW_CONFIG}"
}

main "$@"
