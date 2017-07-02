add_exe_path() {
  export PATH="$PATH:$1"
}

push_exe_path() {
  export PATH="$PATH:$1"
}

prepend_exe_path() {
  export PATH="$1:$PATH"
}

mkcd() {
  mkdir "$@"
  cd "$1"
}

dupfind() {
  local parallel
  parallel="$(command -v parallel)"
  parallel="${parallel:-$(command -v xargs)}"

  local dir
  dir="${1:-.}"
  find "$dir" \( \( -name .git -o -name CVS \) -prune \) -o  \( -type f \) -print0  |
    $parallel -0 shasum |
    sort |
    ${GNU_PREFIX}uniq -w 20 -c |
    sort -nr
}

is-function () {
  whence -w $1 | grep -I function > /dev/null
}

is-alias () {
  whence -w $1 | grep -I alias > /dev/null
}

expand-alias () {
  local POSSIBLE_ALIAS
  if [[ ! -z "$1" ]]; then
    POSSIBLE_ALIAS="$(alias $1)"
    if [[ ! -z "$POSSIBLE_ALIAS" ]]; then
      echo "${POSSIBLE_ALIAS#*=}"
    else
      echo "$1"
    fi
  fi
}