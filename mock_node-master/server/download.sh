#!/bin/bash
#
# Autors:
#   - Cliff La Torre (teocafe@gmail.com)
#

MOCKSERVER_VERSION=3.10.4
MOCKSERVER_URL="https://repo1.maven.org/maven2/org/mock-server/mockserver-netty/$MOCKSERVER_VERSION/mockserver-netty-$MOCKSERVER_VERSION-jar-with-dependencies.jar"

if [ ! -e "mockserver-netty-$MOCKSERVER_VERSION-jar-with-dependencies.jar" ]; then
  curl -O $MOCKSERVER_URL
fi
