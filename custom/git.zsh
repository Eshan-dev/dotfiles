# Run `git pull` and `git remote prune` for remote repos
function gpull() {
    # shellcheck disable=SC2156
    find . -type d -name ".git" -exec sh -c '
        if grep -qs "remote \"origin\"" {}/config; then
            echo {}
            git -C {}/../ pull
            git -C {}/../ remote prune origin
        fi
    ' \;
}

# Run any `git` command for all repos
function gmap() {
    # shellcheck disable=SC2156
    find . -type d -name '.git' -exec sh -c "echo {}; git -C {}/../ $*" \;
}

# Sync origin/master with upstream/master
function gsync() {
    BRANCH="${1:-master}"
    git checkout "$BRANCH"
    git fetch upstream
    git reset --hard "upstream/$BRANCH"
    git push origin "$BRANCH"
}

# Enable assumption for file in repository
alias gignore='git update-index --assume-unchanged'

# Disable assumption for file in repository
alias gremind='git update-index --no-assume-unchanged'

# Run submodule update
alias gupdate='git submodule update --recursive --remote'

# Run `git fetch` with tracing enabled
alias gtrace='GIT_TRACE=1 git fetch'
