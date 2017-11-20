# Python helpers
alias venv='source /usr/local/bin/virtualenvwrapper.sh'

function pipup() {
    pip list --outdated | awk '{if (NR > 2) print $1"=="$3}' | xargs pip install
}