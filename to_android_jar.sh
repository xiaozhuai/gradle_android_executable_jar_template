#!/usr/bin/env bash

androidSdkRoot="${ANDROID_SDK_ROOT}"
if [[ "${androidSdkRoot}" == "" ]]; then
    androidSdkRoot="${ANDROID_HOME}"
fi
if [[ "${androidSdkRoot}" == "" ]]; then
    echo "ANDROID_SDK_ROOT or ANDROID_HOME not defined"
    exit 1
fi

buildToolsVersion=$(ls -tr "${androidSdkRoot}/build-tools/" | tail -1)

buildToolsRoot="${androidSdkRoot}/build-tools/${buildToolsVersion}"

dxExecutable="${buildToolsRoot}/dx"
aaptExecutable="${buildToolsRoot}/aapt"

inputJar=build/libs/$1
outputDir=build/android
outputDex=${outputDir}/classes.dex
outputJar=${outputDir}/$1

rm -f ${outputDex} ${outputJar}
mkdir -p ${outputDir}

${dxExecutable} --dex --output=${outputDex} ${inputJar}


cd ${outputDir}
${aaptExecutable} add $1 classes.dex
cd -