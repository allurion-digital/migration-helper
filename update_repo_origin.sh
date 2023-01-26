#!/usr/bin/env bash
set -o errexit

set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

main() {

    # Moving to the repo top root directoy
    cd "$(git rev-parse --show-toplevel)"

    OLD_REPO_ORIGIN="$(git remote get-url origin)"
    NEW_REPO_ORIGIN="$(echo "${OLD_REPO_ORIGIN}" | sed "s|bitbucket.org|github.com|g" | sed "s|allurion/|allurion-digital/|g")"

    echo "[INFO] Changing remote repo origin"
    echo "[INFO] from: ${OLD_REPO_ORIGIN}"
    echo "[INFO] to: ${NEW_REPO_ORIGIN}"

    git remote set-url origin "${NEW_REPO_ORIGIN}"

    echo "[INFO] Update complete, running 'fetch' now"

    git fetch

    echo "[INFO] Done"
}

main "$@"
