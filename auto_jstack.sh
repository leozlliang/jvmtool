#!/bin/sh
user="www-data"
#sudo -i
#su ${user}

echo "#########Auto Jstack BEGIN########"
echo " "

cpu=$(top -b -n1 | grep "${user}" | head -1 | awk '{print $9}')
pid=$(top -b -n1 | grep "${user}" | head -1 | awk '{print $1}')
threadid=$(top -H -p ${pid} -b -n1 | grep "${user}" | head -1 | awk '{print $1}')
memory=$(top -b -n1 | grep "${user}" | head -1 | awk '{print $10}')
project=$(ps -ef |grep ${pid}| awk '{print $16}')

echo "CPU most hight usgae info:"
echo "  pid=${pid}, threadid=${threadid}, usage=${cpu}, memory=${memory}"
echo "  project: ${project}"

threadid=$(printf "%x \n" ${threadid})

echo "jstack detail:"

jstack ${pid} | grep ${threadid}

echo " "
echo "#########Auto Jstack END########"
