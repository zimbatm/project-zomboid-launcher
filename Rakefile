require 'pathname'
class Pathname
  alias / +
  def =~(other); to_s =~ other end
  def length; to_s.length end
  alias size length
end

BUILD_DIR = Pathname.new("build").expand_path

directory BUILD_DIR

LWJGL_ZIP = BUILD_DIR / "lwjgl-2.7.1.zip" 
LWJGL_URL = "http://sourceforge.net/projects/java-game-lib/files/Official%20Releases/LWJGL%202.7.1/lwjgl-2.7.1.zip/download"
PZ_ZIP = BUILD_DIR / "pz015testversion_5.zip"
PZ_URL = "https://s3.amazonaws.com/alpha.projectzomboid.com/pz015testversion_5.zip"

file LWJGL_ZIP => BUILD_DIR do |t|
  sh "wget -c -O #{t.name}.tmp \"#{LWJGL_URL}\""
  mv "#{t.name}.tmp", t.name
end

file PZ_ZIP => BUILD_DIR do |t|
  sh "wget -c -O #{t.name}.tmp \"#{PZ_URL}\""
  mv "#{t.name}.tmp", t.name
end

file BUILD_DIR / "ProjectZomboid.app.zip" => [LWJGL_ZIP, PZ_ZIP] do
  pza = BUILD_DIR / "ProjectZomboid.app"
  rm_rf pza
  sh "cp -r src/ProjectZomboid.tpl build/ProjectZomboid.app"
  Dir.chdir(pza / "Contents/Resources/Java") do
    sh "unzip #{PZ_ZIP}"
    sh "unzip #{LWJGL_ZIP}"
    sh "rm -rf *.jar *.bat *.dll .metadata"
    sh "cp lwjgl-2.7.1/jar/lwjgl.jar ."
    sh "cp lwjgl-2.7.1/jar/lwjgl_util.jar ."
    sh "cp lwjgl-2.7.1/native/macosx/* ."
    sh "rm -rf lwjgl-2.7.1"
  end
  Dir.chdir(BUILD_DIR) do
    rm_f "ProjectZomboid.app.zip"
    sh "zip -r ProjectZomboid.app.zip ProjectZomboid.app"
  end
end

file BUILD_DIR / "ProjectZomboid.tar.gz" => [LWJGL_ZIP, PZ_ZIP] do
  pz = BUILD_DIR / "ProjectZomboid"
  rm_rf pz
  mkdir_p pz
  sh "cp src/ProjectZomboid.{sh,command} #{pz}"
  Dir.chdir(pz) do
    sh "unzip #{PZ_ZIP}"
    sh "unzip #{LWJGL_ZIP}"
    sh "rm -rf *.jar *.bat *.dll .metadata"
    sh "cp lwjgl-2.7.1/jar/lwjgl.jar ."
    sh "cp lwjgl-2.7.1/jar/lwjgl_util.jar ."
    sh "cp -r lwjgl-2.7.1/native ."
    sh "rm -rf lwjgl-2.7.1"
  end
  Dir.chdir(BUILD_DIR) do
    rm_f "ProjectZomboid.tar.gz"
    sh "tar czvf ProjectZomboid.tar.gz ProjectZomboid"
  end
end

desc "Builds PZ.app for OSX"
task :osx => BUILD_DIR / "ProjectZomboid.app.zip"

desc "Builds PZ for POSIX platforms"
task :posix => BUILD_DIR / "ProjectZomboid.tar.gz"
