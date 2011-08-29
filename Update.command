#!/bin/sh
# OSX runner

cd `dirname $0`
./Update.sh
# Don't exit if there is an error
if [ "$?" -gt 0 ]; then
  echo An error was encountered. Please report at
  echo https://github.com/zimbatm/project-zomboid-posix-launcher/issues/new
fi

echo
echo "Press ENTER to exit."
read ANYTHING
