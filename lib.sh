set -e

check() {
  if ! which $1 >/dev/null 2>&1; then
    echo "Sorry buddy, I need \`$1\` to work properly."
    echo
    echo "Run me again when you installed it."
    echo
    exit 1
  fi
}

fetch() {
  if which wget >/dev/null 2>&1 ; then
    wget --no-check-certificate -c -O ".$1" "$2"
    mv "$1.tmp" "$1"
  elif which curl >/dev/null 2>&1 ; then
    curl -L -C - -o ".$1" "$2"
    mv "$1.tmp" "$1"
  else
    echo 'Woops, this program needs `wget` or `curl` to work properly.'
    exit 1
  fi
}
