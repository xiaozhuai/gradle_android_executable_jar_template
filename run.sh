#!/usr/bin/env bash

jarName=$(cd build/android && ls *.jar)

adb push build/android/${jarName} /data/local/tmp

adb shell CLASSPATH=/data/local/tmp/${jarName} app_process /data/local/tmp net.xiaozhuai.Main "$@"