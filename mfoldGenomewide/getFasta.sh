#!/bin/bash

if [[ $# -ne 4 ]]
then
  printf "%s\n%s\n" "Usage: getFasta chr# start end outFile" "Example: chr16 123000 125000 chr16_1"
  exit 1
fi

for((c=${2}; ((c<=${3}-500)); ((c+=500)))) ; do echo -e "${1}:"${c}"-"$((${c}+500)) ; done > $4

/risapps/rhel7/twoBitToFa/20190311/twoBitToFa -noMask -seqList=$4 ~/ref/hg38.2bit ${4}.fa

exit 0

# vga_mfold.sh ${1}.fa
