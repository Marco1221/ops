#! /bin/bash
read -p "请输入需要kill慢进程的用户名: " user
read -p "请输入需要kill慢进程的用户名: " password
read -p "请输入需要kill慢进程的数据库实例地址: " host
mysql -u$user -h$host -p$password -e "show full processlist;" > ./tmp ; cat ./tmp | grep -E -i "(sleep)|(query)" | awk '{if($6 >= 5 ) print $1}' > ./pids
while read id;
do
    mysql  -u$user -h$host -p$password  -e "kill $id"
    echo "kill $id"
done < ./pids