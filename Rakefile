require 'pathname'
class Pathname
  alias / +
  def =~(other); to_s =~ other end
  def length; to_s.length end
  alias size length
end

BUILD_DIR = Pathname.new("build").expand_path

directory BUILD_DIR

VERSION = "0.1.5d"

LWJGL_URL = "http://sourceforge.net/projects/java-game-lib/files/Official%20Releases/LWJGL%202.7.1/lwjgl-2.7.1.zip/download"
LWJGL_ZIP = BUILD_DIR / "lwjgl-2.7.1.zip"
PZ_URL = "https://s3.amazonaws.com/alpha.projectzomboid.com/pz_0_1_5d.zip"
PZ_ZIP = BUILD_DIR / File.basename(PZ_URL)

desc "Builds PZ.app for OSX"
task :osx

desc "Builds PZ for POSIX platforms"
task :posix




file LWJGL_ZIP => BUILD_DIR do |t|
  sh "wget -c -O #{t.name}.tmp \"#{LWJGL_URL}\""
  mv "#{t.name}.tmp", t.name
end

file PZ_ZIP => BUILD_DIR do |t|
  sh "wget -c -O #{t.name}.tmp \"#{PZ_URL}\""
  mv "#{t.name}.tmp", t.name
end

file "Rakefile"

t = file BUILD_DIR / "ProjectZomboid.app.#{VERSION}.zip" => [LWJGL_ZIP, PZ_ZIP, "Rakefile"] do |t|
  pza = BUILD_DIR / "ProjectZomboid.app"
  rm_rf pza
  sh "cp -r src/ProjectZomboid.tpl build/ProjectZomboid.app"
  Dir.chdir(pza / "Contents/Resources/Java") do
    sh "unzip #{PZ_ZIP}"
    sh "unzip #{LWJGL_ZIP}"
    sh "rm -rf *.jar *.bat *.dll .metadata zomboid/"
    sh "cp lwjgl-2.7.1/jar/lwjgl.jar ."
    sh "cp lwjgl-2.7.1/jar/lwjgl_util.jar ."
    sh "cp lwjgl-2.7.1/native/macosx/* ."
    sh "rm -rf lwjgl-2.7.1"
  end
  sh "sed -e 's/$VERSION/#{VERSION}/g' -i.bak #{pza}/Contents/Info.plist"
  rm pza / "Contents/Info.plist.bak"
  Dir.chdir(BUILD_DIR) do
    rm_f t.name
    sh "zip -r #{t.name} ProjectZomboid.app"
  end
end
task :osx => t.name

t = file BUILD_DIR / "ProjectZomboid.#{VERSION}.tar.gz" => [LWJGL_ZIP, PZ_ZIP, "Rakefile"] do |t|
  pz = BUILD_DIR / "ProjectZomboid"
  rm_rf pz
  mkdir_p pz
  sh "cp src/ProjectZomboid.{sh,command} #{pz}"
  sh "cp src/ProjectZomboid_optimized.sh #{pz}"
  Dir.chdir(pz) do
    sh "unzip #{PZ_ZIP}"
    sh "unzip #{LWJGL_ZIP}"
    sh "rm -rf *.jar *.bat *.dll .metadata zomboid/"
    sh "cp lwjgl-2.7.1/jar/lwjgl.jar ."
    sh "cp lwjgl-2.7.1/jar/lwjgl_util.jar ."
    sh "cp -r lwjgl-2.7.1/native ."
    sh "rm -rf lwjgl-2.7.1"
  end
  Dir.chdir(BUILD_DIR) do
    rm_f t.name
    sh "tar czvf #{t.name} ProjectZomboid"
  end
end
task :posix => t.name
