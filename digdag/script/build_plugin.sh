#! /usr/bin/env bash
set -e

url=$1
# github's url is expected
# for example: https://github.com/hiroyuki-sato/digdag-plugin-mysql.git

dir_name=$(basename $url | cut -d . -f 1)
# for example: digdag-plugin-mysql
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")

cd /opt/digdag/plugin
git clone $url
cd $dir_name

# build 
digdag_version=$(/opt/digdag/bin/digdag version --version)
sed -i "s/def digdagVersion = .*/def digdagVersion = '${digdag_version}'/g" build.gradle
./gradlew publish

cp -r ./build/repo/* /opt/digdag/repo/
