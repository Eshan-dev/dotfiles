# Run `git pull` and `git remote prune` for remote repos
function gpull() {
    find . -type d -name ".git" -exec sh -c '
        dir="$1"
        repo="$2"
        if grep -qs "remote .$repo." $dir/config; then
            echo "$dir"
            git -C "$dir/../" pull "$repo"
            git -C "$dir/../" remote prune "$repo"
        fi
    ' _ {} "${1:-origin}" \;
}

# Run any `git` command for all repos
function gmap() {
    find . -type d -name '.git' -exec sh -c '
        dir="$1"
        command="$2"
        echo "$dir"
        git -C "$dir/../" $command
    ' _ {} "$*" \;
}

# Sync current/branch with parent/branch
function gsync() {
    branch="$(git symbolic-ref --short HEAD)"
    current="${1:-origin}"
    parent="${2:-upstream}"
    git fetch "$parent"
    git reset --hard "$parent/$branch"
    git push "$current" "$branch"
}

# Run `git fetch` with tracing enabled
alias gtrace='GIT_TRACE=1 git fetch'
