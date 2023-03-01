#!/usr/bin/env bash
set -e

androidSdkRoot="${ANDROID_SDK_ROOT}"
if [[ "${androidSdkRoot}" == "" ]]; then
    androidSdkRoot="${ANDROID_HOME}"
fi
if [[ "${androidSdkRoot}" == "" ]]; then
    echo "ANDROID_SDK_ROOT or ANDROID_HOME not defined"
    exit 1
fi

buildToolsVersion="30.0.3"

buildToolsRoot="${androidSdkRoot}/build-tools/${buildToolsVersion}"

dxExecutable="${buildToolsRoot}/dx"
aaptExecutable="${buildToolsRoot}/aapt"

inputJar=build/libs/$1
outputDir=build/android
outputDex=${outputDir}/classes.dex
outputJar=${outputDir}/$1

if [[ ! -f ${inputJar} ]]; then
    echo "${inputJar} not found"
    exit 1
fi

rm -f ${outputDex} ${outputJar}
mkdir -p ${outputDir}

${dxExecutable} --dex --output=${outputDex} ${inputJar}

cd ${outputDir}
${aaptExecutable} add $1 classes.dex
cd -
