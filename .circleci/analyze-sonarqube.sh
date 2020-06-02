#!/bin/bash
#################################################
# based on https://github.com/Sagacify/ci-tools
#################################################
SONAR_VERSION="sonar-scanner-cli-3.2.0.1227"
SONAR_DIR="sonar-scanner-3.2.0.1227"

wget -P $HOME -N "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SONAR_VERSION}.zip"
unzip -d $HOME $HOME/$SONAR_VERSION.zip

echo "unzipped sonar cube $HOME $HOME/$SONAR_VERSION.zip"

DEFAULT_SONAR_PARAMS="-Dsonar.login=$SONAR_TOKEN \
                      -Dsonar.projectName=oohmatch \
                      -Dsonar.projectVersion=$CIRCLE_BUILD_NUM"

echo "Analyzing ${CIRCLE_BRANCH} branch to push issues to SonarQube server"
$HOME/$SONAR_DIR/bin/sonar-scanner $DEFAULT_SONAR_PARAMS \
-Dsonar.projectKey=$CIRCLE_PROJECT_USERNAME:$CIRCLE_PROJECT_REPONAME;