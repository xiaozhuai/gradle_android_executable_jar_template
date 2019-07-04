#!/usr/bin/env bash

jarName=$(cd build/android && ls *.jar)

if [[ ${jarName} = "" ]]; then
    echo "No jar found in build/android"
    exit 1
fi

adb push build/android/${jarName} /data/local/tmp

adb shell CLASSPATH=/data/local/tmp/${jarName} app_process /data/local/tmp net.xiaozhuai.Main "$@"