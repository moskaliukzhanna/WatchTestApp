#!/usr/bin/env bash
set -u

if [[ ! -d build ]]
then mkdir build
fi

#rm build/test_script_log.log
#rm build/test_attach_log.log
#touch build/test_script_log.log
#touch build/test_attach_log.log

MY_BUILD_DIR=$(pwd)/build

# Get the connected device ID

PHONE=$(ios-deploy -cj | python3 -c "import sys, json; print(json.load(sys.stdin)['Device']['DeviceIdentifier'])")

if [[ -z "PHONE" ]]
then
  echo "This script needs a connected iPhone with a paired watch to run the app."
  exit;
else
  echo "Building for the device: $PHONE"
  echo "Build directory: $MY_BUILD_DIR"
fi

#WATCH_SCHEME="Watch"

flutter pub get

echo "Running pod install..."
pod install

echo "Building app..."
(xcodebuild 									            \
-workspace WatchTesterAppExample.xcworkspace                \
-scheme "WatchTesterAppExample" 							\
-destination "platform=iOS,id=${PHONE}" 		            \
BUILD_DIR=${MY_BUILD_DIR}                                   \
)
echo "Done"

#ios-deploy -rI -i "$PHONE" -b "$MY_BUILD_DIR"/Integration-iphoneos/Runner.app > build/test_script_log.log &

# Wait for observatory URL in logs file and save the URL to enviroment variable
echo 'Installing app on device, waiting for it to launch...'
#until grep -m 1 "Observatory listening on" build/test_script_log.log; do :
#sleep 1;
#done

#(flutter attach > build/test_attach_log.log) &
#echo 'Waiting for Observatory URL'
#until CONNECTION_URL=$(sed -n 's/^.*Observatory debugger and profiler on .* at:[[:space:]]//p' build/test_attach_log.log) && echo ${CONNECTION_URL} | grep -m 1 "http"; do :
#sleep 1;
#done

#export VM_SERVICE_URL=${CONNECTION_URL}

#function runTest {
#    flutter test -j 1 test_integration/integration_test.dart
#}

read  -n 1 -p "Please verify that the Watch App is installed and launch it. When it is running - press any key to continue." input

#CODE=0
#echo "Running tests..."
#echo "It may take a few seconds for the Greybox Tester to connect."
#runTest
#CODE=$?
# rm build/test_script_log.log
#exit ${CODE};

