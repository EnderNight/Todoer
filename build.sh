#!/bin/bash

VERSION=$(cat pubspec.yaml | grep version | cut -d ':' -f2 | tr -d ' ')
BUILD_DIR=build/app/outputs/flutter-apk

rm -rf dist/
flutter clean -v

flutter build apk --split-per-abi -v

mkdir -vp dist/android

mv -v ${BUILD_DIR}/app-arm64-v8a-release.apk dist/android/todoer-v${VERSION}.apk
mv -v ${BUILD_DIR}/app-arm64-v8a-release.apk.sha1 dist/android/todoer-v${VERSION}.apk.sha1

zip -v dist/todoer-v${VERSION}-android.zip dist/android/*
