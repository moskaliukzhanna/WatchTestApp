#!/bin/bash

set -u

#Run WatchTesterApp tests.\n
#Requires a running iOS + watchOS simulator pair.\n

MY_BUILD_DIR=$(pwd)/build

# Get the running sim ID

DEVICE_PAIR=$(xcrun simctl list | sed -n '/Device Pairs/,$p' | sed -n '/active, connected/,$p' | head -3)
BUNDLEID=$(xcodebuild  -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER | rev | cut -d" " -f1 | rev)


if [ -z "$DEVICE_PAIR" ]
then
  echo "This script needs a running Simulator with a paired watch to run the app."
  exit;
else
  if [ -z "$BUNDLEID" ]
    then
      echo "Could not retreive Product Bundle Identifier from Xcode project. You'll need to launch the app manually once build is finished."
    else
      echo "Application $BUNDLEID:"
  fi
  echo "Building for the device pair: $DEVICE_PAIR"
  echo "Build directory: $MY_BUILD_DIR"
fi

PHONE=$(echo "$DEVICE_PAIR" | grep 'Phone' | grep -oE '[A-Z0-9-]{36}')
WATCH=$(echo "$DEVICE_PAIR" | grep 'Watch' | grep -oE '[A-Z0-9-]{36}')

WATCH_SCHEME="Watch"

echo "Running pod install..."
pod install

echo "Cleaning out old installations..."
xcrun simctl terminate "$PHONE" "$BUNDLEID"
xcrun simctl uninstall "$WATCH" "$BUNDLEID.watchkitapp"
xcrun simctl uninstall "$PHONE" "$BUNDLEID"

echo "Building app..."
(xcodebuild 											  \
-workspace WatchTesterAppExample.xcworkspace 		      \
-scheme "WatchTesterAppExample" 			              \
-destination "platform=iOS Simulator,id=${PHONE}" 		  \
BUILD_DIR=$MY_BUILD_DIR  							      \
#xcpretty
)
echo "Done"

echo "Installing app..."
xcrun simctl install "$PHONE" "$MY_BUILD_DIR"/Debug-iphonesimulator/WatchTesterAppExample.app
xcrun simctl install "$WATCH" ""$MY_BUILD_DIR"/Debug-watchsimulator/WatchTesterAppExample WatchKit App.app"

#xcrun simctl launch $PHONE $BUNDLEID
#xcrun simctl launch $WATCH $BUNDLEID.watchkitapp


#xcrun simctl terminate "$PHONE" "$BUNDLEID"
#xcrun simctl terminate "$WATCH" "$BUNDLEID.watchkitapp"


echo "Starting Watch client..."
(xcodebuild test                                          \
#-workspace WatchTesterAppExample.xcworkspace              \
#-scheme "WatchTesterAppExample"                           \
#-destination "platform=iOS Simulator,id=${PHONE}" &         -- DON'T NEED TO RUN TESTS ON IPHONE - IT IS APPIUM's RESPONSIBILITY (FOR NOW)
#xcodebuild test                                           \
                                     
-workspace WatchTesterAppExample.xcworkspace               \
-scheme "WatchTesterAppExample WatchKit App"               \
-destination "platform=watchOS Simulator,id=${WATCH}"      )
echo "Done"
