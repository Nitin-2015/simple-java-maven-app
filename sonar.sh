#!/bin/bash
export SONAR_SCANNER_OPTS="-Xmx512m"
mkdir /tmp -p
cd /tmp
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
unzip sonar-scanner-cli-4.2.0.1873-linux.zip
mkdir /tmp/sonar-scanner/ -p
echo "sonar.host.url=https://sonarcloud.io \n sonar.sourceEncoding=UTF-8" > /tmp/sonar-scanner-4.2.0.1873-linux/conf/sonar-scanner.properties
export PATH="$PATH:/tmp/sonar-scanner-4.2.0.1873-linux/bin"
sonar-scanner -v
mkdir -p ${WORKSPACE}/target/.sonar
/tmp/sonar-scanner-4.2.0.1873-linux/bin/sonar-scanner \
      -Dsonar.host.url=https://sonarcloud.io \
      -Dsonar.projectKey=Nitin-2015_simple-java-maven-app \
      -Dsonar.projectName=simple-java-maven-app \
      -Dsonar.projectVersion=${BUILD_ID} \
      -Dsonar.projectBaseDir=${WORKSPACE}/simple-java-maven-app \
      -Dsonar.java.binaries=simple-java-maven-app\target\classes\com\mycompany\app \
      -Dsonar.login=11a95d1648bb6b9adef877bbde6e49254af51ead \
      -Dsonar.skipPackageDesign=true \
      -Dsonar.exclusions=**/*.xml \
      -Dsonar.working.directory=${WORKSPACE}/target/.sonar \
ls -lrt
pwd