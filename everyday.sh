#!/bin/bash
#定义子项目模块
facebase_core="cdhfacebase-core";
facebase_native="cdhfacebase-native";
facebase_tools="cdhfacebase-tools"; 
facebase_webapp="cdhfacebase-web";
facebase_ws="cdhfacebase-ws";
mvn clean>log;
cd $facebase_native;
mvn deploy>>../log;
cd ..;
cd $facebase_core; 
mvn deploy>>../log;
cd ..;
cd $facebase_tools;
mvn package>>../log;
cd ..;
cd $facebase_ws;
mvn package>>../log;
cd ..;
cd $facebase_webapp;
mvn package>>../log;
cd ..;
mvn com.hikvision:maven-sendmail-plugin:sendEmail
