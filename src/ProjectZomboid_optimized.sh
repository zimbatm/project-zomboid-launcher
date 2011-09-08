#!/bin/sh
#
# ProjectZomboid Launcher
#  by zimbatm
set -e

cd `dirname $0`

check() {
  if ! which $1 >/dev/null 2>&1; then
    echo "Sorry buddy, I need \`$1\` to work properly."
    echo
    echo "Run me again when you installed it."
    echo
    exit 1
  fi
}
check java
check uname

case "`uname`" in
  Darwin)
    platform=macosx
    ;;
  Linux)
    platform=linux
    ;;
  *)
    echo Unknown platform: `uname`
    exit 1
    ;;
esac

exec java -Xmx1g -Xms900m -Xmn700m -Xss128k -XX:+UseParallelGC -XX:ParallelGCThreads=20 -XX:+UseParallelOldGC -XX:+AggressiveOpts -XX:+UseBiasedLocking -Djava.library.path=native/$platform -Dsun.java2d.noddraw=true -Dsun.awt.noerasebackground=true -Dsun.java2d.d3d=false -Dsun.java2d.opengl=false -Dsun.java2d.pmoffscreen=false -cp .:lwjgl.jar:lwjgl_util.jar zombie.FrameLoader
