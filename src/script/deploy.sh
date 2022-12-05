#!/bin/bash

set -euo pipefail

mvn clean
mvn compile
mvn package

ARTIFACT_ID=$(mvn org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.artifactId -B | grep -v '\[')
GROUP_ID=$(mvn org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.groupId -B | grep -v '\[')
VERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version -B | grep -v '\[')

mvn deploy:deploy-file \
    -DgroupId=${GROUP_ID} \
    -DartifactId=${ARTIFACT_ID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -Dfile=target/${ARTIFACT_ID}-${VERSION}.jar \
    -DrepositoryId=github \
    -Durl=https://maven.pkg.github.com/signal-ai/${ARTIFACT_ID} \
    -Dmaven.install.skip=true
