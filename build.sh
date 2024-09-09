#!/bin/bash

VERSION="$(cat pubspec.yaml | grep version | cut -d ':' -f2 | tr -d ' ')"
BUILD_DIR=build/app/outputs/flutter-apk
DIST_DIR=dist

rm -rf "${DIST_DIR}"

flutter build apk --split-per-abi

mkdir -vp "${DIST_DIR}/android"

mv -v "${BUILD_DIR}/app-arm64-v8a-release.apk" "${DIST_DIR}/android/todoer-v${VERSION}.apk"
mv -v "${BUILD_DIR}/app-arm64-v8a-release.apk.sha1" "${DIST_DIR}/android/todoer-v${VERSION}.apk.sha1"

zip -v "${DIST_DIR}/todoer-v${VERSION}-android.zip" ${DIST_DIR}/android/*

gh release create "v${VERSION}" --notes "Todoer release v${VERSION}" ${DIST_DIR}/*.zip
