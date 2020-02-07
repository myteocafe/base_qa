#!/bin/bash
#
# Autors:
#   - Cliff La Torre (modlost)
#

MOCKSERVER_VERSION=3.10.4
MOCKSERVER_URL="https://repo1.maven.org/maven2/org/mock-server/mockserver-netty/$MOCKSERVER_VERSION/mockserver-netty-$MOCKSERVER_VERSION-jar-with-dependencies.jar"

if [ -z "$AWS_ACCESS_KEY_ID" -o -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "ERROR: Required environment variables are: \$AWS_ACCESS_KEY_ID \$AWS_SECRET_ACCESS_KEY"
  exit 1
fi

if [ ! -e "mockserver-netty-$MOCKSERVER_VERSION-jar-with-dependencies.jar" ]; then
  curl -o server/mockserver-netty-$MOCKSERVER_VERSION-jar-with-dependencies.jar $MOCKSERVER_URL 
fi


eval $(aws ecr get-login --region us-west-2)
docker-compose build
docker-compose push
