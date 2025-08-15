#!/usr/bin/env bash

set -euo pipefail

PATH_TO_IGNORED_FILES="eslint/ignored_files.json"

check_if_file_exists() {
	local file="$1"
	if [[ -f "$file" ]]; then
		return 0
	else
		echo "File $file does not exist."
		return 1
	fi
}

get_staged_files() {
	git diff --cached --name-only
}

process_files() {
	local ignored_files=()
	while IFS= read -r line; do
		ignored_files+=("$line")
	done < <(jq -r '.files[]' "$PATH_TO_IGNORED_FILES" 2>/dev/null || true)

	if [[ "${#ignored_files[@]}" -eq 0 ]]; then
		echo "No ignored files found in $PATH_TO_IGNORED_FILES."
		return 0
	fi

	local staged_files=()
	while IFS= read -r line; do
		staged_files+=("$line")
	done < <(get_staged_files)

	local files_to_remove=()
	for staged_file in "${staged_files[@]}"; do
		for ignored_file in "${ignored_files[@]}"; do
			if [[ "$staged_file" == "$ignored_file" ]]; then
				files_to_remove+=("$staged_file")
				break
			fi
		done
	done

	if [[ "${#files_to_remove[@]}" -eq 0 ]]; then
		echo "✅ No ignored files were staged. Nothing to update."
		return 0
	fi

	# Build new ignored_files list without the removed ones
	local new_ignored_files=()
	for ignored_file in "${ignored_files[@]}"; do
		skip=false
		for removed_file in "${files_to_remove[@]}"; do
			if [[ "$ignored_file" == "$removed_file" ]]; then
				skip=true
				break
			fi
		done
		if [[ "$skip" == false ]]; then
			new_ignored_files+=("$ignored_file")
		fi
	done

	# Sort and deduplicate
	local sorted_unique
	sorted_unique=$(printf '%s\n' "${new_ignored_files[@]}" | sort -u)

	local new_ignored_sorted_files=()
	for line in $sorted_unique; do
		new_ignored_sorted_files+=("$line")
	done

	jq --indent 4 --argjson newFiles "$(printf '%s\n' "${new_ignored_sorted_files[@]}" | jq -R . | jq -s .)" \
		'.files = $newFiles' "$PATH_TO_IGNORED_FILES" >"$PATH_TO_IGNORED_FILES.tmp" &&
		mv "$PATH_TO_IGNORED_FILES.tmp" "$PATH_TO_IGNORED_FILES"

	git add "$PATH_TO_IGNORED_FILES"

	echo "✅ Updated $PATH_TO_IGNORED_FILES with the new ignored files."
}

check_if_jq_is_installed() {
	if ! command -v jq &>/dev/null; then
		echo "jq is not installed. Please install jq to run this script."
		exit 1
	fi
}

main() {
	check_if_file_exists "$PATH_TO_IGNORED_FILES"
	check_if_jq_is_installed
	process_files
	exit 0
}

main
