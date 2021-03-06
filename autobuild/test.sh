#!/bin/sh

# Go to project root
cd `dirname $0`/..

VERSION=`cat version.txt`

# Make sure it is already built
if [ ! -f dist/Brainclouds2s-$VERSION.jar ]; then
    autobuild/build.sh
fi

# Set a temporary build folder
mkdir -p testBuild
javac -cp lib/junit-4.12.jar:dist/Brainclouds2s-$VERSION.jar -d ./testBuild `find ./test -name "*.java"`
java -cp lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar:dist/Brainclouds2s-$VERSION.jar:testBuild/ org.junit.runner.JUnitCore com.bitheads.braincloud.s2s.Brainclouds2sSetupTest
# Persist test results
TEST_RESULT=$?

# Cleanup
rm -rf testBuild

# Return test resutls
exit $TEST_RESULT