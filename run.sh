#!/bin/bash
echo "choose lifecycle phase";

#定义操作类型
#1）Package test 编译，单元测试后打包
#2）Package skip test 跳过单元测试直接打包
#3）Intall  将jar包发布到本地仓库
#4）Deploy  将jar包发布到远程仓库
#5）Clean  清除target目录生成结果
#6）Cplib  将依赖包拷贝到集群各个机器上
#7）Deploywar 将web-app下war包发布到tomcat中，并重启tomcat服务
package_test="package test";
package_skiptest="package skip test";
install="install";
deploy="deploy";
clean="clean";
cplib="cplib";
deploywar="deploywar";
svn_update="svn update";

#定义子项目模块
videobase_core="cdhvideobase-core";
videobase_native="cdhvideobase-native";
videobase_tools="cdhvideobase-tools"; 
videobase_utils="cdhvideobase-utils";
videobase_webapp="cdhvideobase-web";
videobase_ws="cdhvideobase-ws";


select phase in "$package_test" "$package_skiptest" "$install" "$deploy" "$clean" "$cplib" "$deploywar" "$svn_update";do
	echo $phase;
	if [ "$phase" = "$deploywar"  ];then
		cd $videobase_webapp;
		#拷贝war到tomcat目录并重启apachetomcat
		./deploywar.sh;
	    exit;
	fi
	#svn更新
	if [ "$phase" = "$svn_update" ];then
		svn update;
		exit;
	fi
	break;
done

echo "choose :project";
#选择操作的子项目模块
select project in "$videobase_utils" "$videobase_core" "$videobase_native" "$videobase_tools" "$videobase_webapp" "$videobase_ws";do
#echo $project
break;
done
case $project in
  $videobase_utils) 
     echo $project;
     cd $project;
     case $phase in
     $package_test) mvn package;;
     $package_skiptest)mvn package -Dmaven.test.skip=true;;
     $install)mvn install -Dmaven.test.skip=true;;
     $deploy)mvn deploy -Dmaven.test.skip=true;;
     $clean)mvn clean;;
     $cplib) ./buildclasspath.sh&&./deploylib.sh diff_classpath.txt;;  
     esac
     ;; 
  $videobase_core) 
     echo $project;
     cd $project;
     case $phase in
     $package_test) mvn package;;
     $package_skiptest)mvn package -Dmaven.test.skip=true;;
     $install)mvn install -Dmaven.test.skip=true;;
     $deploy)mvn deploy -Dmaven.test.skip=true;;
     $clean)mvn clean;;
     $cplib) ./buildclasspath.sh&&./deploylib.sh diff_classpath.txt;;  
     esac
     ;; 
 $videobase_native)
     echo $project;
     cd $project;
     case $phase in
     $package_test) mvn package;;
     $package_skiptest)mvn package -Dmaven.test.skip=true;;
     $install)mvn install -Dmaven.test.skip=true;;
     $deploy)mvn deploy -Dmaven.test.skip=true;;
     $clean)mvn clean;;
     $cplib) ./buildclasspath.sh&&./deploylib.sh diff_classpath.txt;; 
     esac
     ;;
  $videobase_tools)
     echo $project;
     cd $project;
     case $phase in
     $package_test) mvn package;;
     $package_skiptest)mvn package -Dmaven.test.skip=true;;
     $install)mvn install -Dmaven.test.skip=true;;
     $deploy)mvn deploy -Dmaven.test.skip=true;;
     $clean)mvn clean;;
     $cplib) ./buildclasspath.sh&&./deploylib.sh diff_classpath.txt;; 
     esac
     ;;
  $videobase_webapp)
     echo $project;
     cd $project;
     case $phase in
     $package_test) mvn package;;
     $package_skiptest)mvn package -Dmaven.test.skip=true;;
     $install)mvn install -Dmaven.test.skip=true;;
     $deploy)mvn deploy -Dmaven.test.skip=true;;
     $clean)mvn clean;;
     $cplib) ./buildclasspath.sh&&./deploylib.sh diff_classpath.txt;; 
     esac
     ;;
$videobase_ws)
     echo $project;
     cd $project;
     case $phase in
     $package_test) mvn package;;
     $package_skiptest)mvn package -Dmaven.test.skip=true;;
     $install)mvn install -Dmaven.test.skip=true;;
     $deploy)mvn deploy -Dmaven.test.skip=true;;
     $clean)mvn clean;;
     $cplib) ./buildclasspath.sh&&./deploylib.sh diff_classpath.txt;; 
     esac
     ;;
esac
