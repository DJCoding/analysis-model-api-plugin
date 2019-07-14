#!/bin/bash

JENKINS_HOME=../docker/volumes/jenkins-home

mvn clean install || { echo "Build failed"; exit 1; }

echo "Installing plugin in $JENKINS_HOME"

rm -rf $JENKINS_HOME/plugins/analysis-model*
cp -fv target/analysis-model-api.hpi $JENKINS_HOME/plugins/analysis-model-api.jpi

IS_RUNNING=`docker-compose ps -q jenkins-master`
if [[ "$IS_RUNNING" != "" ]]; then
    echo "Restarting Jenkins..."
    docker-compose restart
fi
