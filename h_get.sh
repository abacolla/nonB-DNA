#!/bin/bash
# h_get.sh -- find triplex-forming motifs in fasta files

# $1 = input fasta file with 1 or more sequences
# a = query DNA sequence stripped of new lines
# b = DNA sequence left stem
# c = DNA sequence right stem
# d = right stem complementary to b
# e = adjusted DNA sequence length
# f = stem length
# g = spacer length
# h = maximum spacer size
# i = DNA sequence length
# j = minimum stem length
# k = maximum stem length
# m = start position right stem
# n = start position left stem
# o = chr number
# p = start position DNA sequence
# q = end position DNA sequence
# s = minimum spacer size
# t = number of triplex-forming repeats
# u = breakpoint position
# v = loop through fasta files
# w = file redirection

  # Step 1 -- Define Functions
function spacer_ab () {
for ((g=s; g<=h; ++g))
do
  m=$(( $n + $f + $g))
  c=${a:m:f}
  d=`echo $c | rev`
    if [[ $b = $d ]]
    then 
      printf %s"\t"%.0f"\t"%g"\t"%g"\t"%g"\t"%s"\t"%s"\n" $o `expr $n + $p` $f $g `expr $n + $f + $g / 2 - $u` $b $c >> ${w}_triplex
      n=$(( $n + 2 * $f + $g - 11 ))
      t=$(( $t + 1 ))
      break
    fi
done
}

function stem_ab () {
for ((f=k; f>=j; --f))
do
  b=${a:n:f}
  if [[ $b =~ ^[GA]*$ || $b =~ ^[CT]*$ ]] 
  then spacer_ab
  fi  
done
}

  # Step 2 -- Body 
csplit -s -n 2 -f $1_ $1 '/^>/' '{*}'
for v in ${1}_[0-9][0-9]
do
  if [[ -s $v ]]
  then
    j=6; k=50; h=7; n=0; s=0; t=0  
    a="`awk '!/^>/ { printf "%s", $0 }; END { printf "%s", "\n" }' $v`"
    o=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f2`
    p=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f3`
    q=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f4`
    i=$(( $q - $p + 1 ))
    e=$(( $i + 1 - 2 * $j ))
    u=$(( $i / 2 ))
    w=$1  
    awk '/^>/' $v >> $1_triplex
      while [[ "$n" -le "$e" ]]
      do
        stem_ab
        n=$(( $n + 1 ))   
      done
        printf %s"\t"%.0f"\n" "The number of Triplex-Forming Repeats is:" $t >> $1_triplex
        rm $v
 fi
done
rm $1_00
exit 0 ;
