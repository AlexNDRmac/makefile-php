#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -u  Treat unset variables as an error when substituting.

set -eu
set -o pipefail

# Each Releases into CHANGELOG should starts from H2 markdown tag: ## [version] - YYYY-MM-DD
# Release notes topics (Added, Changed, etc..) should starts from H3 markdown tag: ### Added
# Example:
#     ## [1.0.0] - 2021-01-01
#     ### Added
#     - Feature description
#     ### Changed
#     - Changes description
#
#     ## [0.0.0] - 2020-01-01
#     ### Added
#     - First release description

# Get Release notes for the latest release from CHANGELOG.md
# How to use:
#   release-notes.sh CHANGELOG.md

startLine=$(cat "$1" | grep -nE "^### " | head -n 1 | cut -d ":" -f 1)
finishLine=$(($(cat "$1" | grep -nE "^## " | head -n 2 | tail -n 1 | cut -d ":" -f 1) - 1))
changelog=$(sed -n "${startLine},${finishLine}p" "$1");


: "${GITHUB_ACTIONS:=0}"

if [ "$GITHUB_ACTIONS" = "true" ]
then
	changelog="${changelog//'%'/'%25'}"
	changelog="${changelog//$'\n'/'%0A'}"
	changelog="${changelog//$'\r'/'%0D'}"
fi

echo "${changelog}"
