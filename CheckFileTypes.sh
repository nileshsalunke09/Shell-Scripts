#!/bin/bash
echo -n "Input the path to Directory: "
read DIR
cd $DIR
find . -type f -ls | awk '{print $11}' > /root/out.txt
for i in  $(cat /root/out.txt);
do
file $i 
ls -l $i | awk {'print $5'} 
done
