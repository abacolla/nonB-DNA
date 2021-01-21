#!/bin/bash

if [[ $# -ne 1 ]]
then
  echo -e "\nUsage: nonB_getRes.sh file_suffix(dr | ir | q1k | z1k | triplex)\n"
  exit 1
fi

for i in *$1
do
  a=`grep "The number" $i | sed -e 's/The number.*\t//'`
  printf "%d\n" $a >> ${1}_out.txt
done
exit 0
