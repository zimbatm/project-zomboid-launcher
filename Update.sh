#!/bin/sh
#
# Updates the Launcher for new versions
#

cd `dirname $0`

. lib.sh

launcher_url="https://github.com/zimbatm/project-zomboid-posix-launcher/zipball/master"
branch="zimbatm-project-zomboid-posix-launcher"

unpack() {
  echo
  echo "Update found, unpacking..."
  mv launcher-new.zip launcher.zip
  unzip -q launcher.zip
  mv $branch-*/* .
  rm -rf $branch-*
}

rm -rf $branch-*

fetch launcher-new.zip "$launcher_url"

if [ -f launcher.zip ]; then
  if ! diff launcher.zip launcher-new.zip ; then
    unpack
  else
    rm launcher-new.zip
    echo
    echo "No update found..."
  fi
else
  unpack
fi
