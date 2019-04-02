#!/usr/bin/env bash
#
# installs how
##################################################

set -e

readonly HOW="how"
readonly INSTALL_PATH="/usr/local/how"
readonly INSTALL_ALIAS_PATH="/usr/local/bin"
readonly GIT_URL="https://github.com/jasonvolpe/how.git"
readonly HOW_CONFIG="${HOME}/.how"

# param 1: path of source repo (optional)
function main() {
	local path
	local alias_path
	local repo
	local branch

	path="${INSTALL_PATH}"
	alias_path="${INSTALL_ALIAS_PATH}/${HOW}"
	repo="${1:-$GIT_URL}"
	branch="$(git rev-parse --abbrev-ref HEAD)"

	# Clone how repo
	if [[ $(test -w "${path}") ]]; then
		echo "Cloning ${repo}:${branch} to ${path}"
		git clone -b "${branch}" --single-branch "${repo}" "${path}" || exit 1
	else
		# Checkout current branch
		echo "Checking out ${branch}"
		pushd ${INSTALL_PATH}
		git fetch
		git checkout "${branch}"
		popd
	fi

	# Create symlink
	echo "Deleting symlink ${alias_path}"
	rm ${alias_path}
	if [[ $(test -w "${alias_path}") ]]; then
		echo "Creating symlink ${alias_path}"
		ln "${path}/${HOW}" "${alias_path}" || exit 3
	fi

	# Write install path to $HOME/.how
	echo "HOW_ROOT=\"${path}\"" > "${HOW_CONFIG}"
}

main "$@"
