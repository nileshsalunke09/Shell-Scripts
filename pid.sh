#!/bin/bash

TOMCAT_HOME=/usr/local/openspecimen/tomcat-as
SERVICE_NAME=tomcat

startUp(){
$TOMCAT_HOME/bin/startup.sh
}

checkPid(){
if [ -f "$TOMCAT_HOME/bin/pid.txt" ]
then
PROCESS_ID=$(cat $TOMCAT_HOME/bin/pid.txt)
RUNNING_PID=$(ps -ef | grep $SERVICE_NAME | grep -v grep | awk '{print $2}')
if [ "${PROCESS_ID}" == "${RUNNING_PID}" ]
then
  exit;
elif [ "${PROCESS_ID}" != "${RUNNING_PID}" ]
then
  kill -9 $RUNNING_PID 
  rm -rf $TOMCAT_HOME/bin/pid.txt
fi
fi
}

main(){
checkPid
startUp
}
main;
