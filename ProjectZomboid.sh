#!/bin/sh

cd `dirname $0`

set -e

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

pz=pz015testversion_5.zip
lwjgl=lwjgl-2.7.1

if ! [ -f $lwjgl.zip ]; then
  wget -O $lwjgl.zip "http://sourceforge.net/projects/java-game-lib/files/Official%20Releases/LWJGL%202.7.1/lwjgl-2.7.1.zip/download"
fi

if ! [ -d $lwjgl ]; then
  unzip $lwjgl.zip
fi

if ! [ -f $pz ]; then
  wget -O $pz "https://s3.amazonaws.com/alpha.projectzomboid.com/pz015testversion_5.zip"
  rm -rf pz
fi

if [ ! -d pz ]; then
  mkdir pz
  cd pz
  unzip ../$pz
  cd ..
fi

cd pz
exec java -Xmx512m -Djava.library.path=../$lwjgl/native/$platform -Dsun.java2d.noddraw=true -Dsun.awt.noerasebackground=true -Dsun.java2d.d3d=false -Dsun.java2d.opengl=false -Dsun.java2d.pmoffscreen=false -cp .:zombie.jar:../$lwjgl/jar/lwjgl.jar:../$lwjgl/jar/lwjgl_util.jar zombie.FrameLoader
