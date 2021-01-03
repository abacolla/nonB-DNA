#!/bin/bash
# ir_get.sh -- find inverted repeats in fasta files

# $1 = target fasta file
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
# t = number of inverted repeats
# u = breakpoint position
# v = loop through fasta files
# w = file redirection

  # Step 1 -- Define Functions
function spacer_ab () {
for ((g=s; g<=h; ++g))
do
  m=$(( $n + $f + $g))
  c=${a:m:f}
  d=`echo $c | tr 'ACGT' 'TGCA' | rev`
    if [[ $b == $d ]]
    then 
      printf %s"\t"%0.d"\t"%g"\t"%g"\t"%g"\t"%s"\t"%s"\n" $o `expr $n + $p + 1` $f $g `expr $n + $f + $g / 2 - $u` $b $c >> ${w}_ir
      n=$(( $n + $f ))
      t=$(( $t + 1 ))
      break
    fi
done
}

function stem_ab () {
for ((f=k; f>=j; --f))
do
  b=${a:n:f}
  spacer_ab
done
}

  # Step 2 -- Body 
csplit -s -n 2 -f $1_ $1 '/^>/' '{*}'
for v in ${1}_[0-9][0-9]
do
  if [[ -s $v ]]
  then
    j=7; k=30; h=7; n=0; s=0; t=0  
    a="`gawk '!/^>/ { printf "%s", $0 }; END { printf "%s", "\n" }' $v`"
    o=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f2`
    p=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f3`
    q=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f4`
    i=$(( $q - $p + 1 ))
    e=$(( $i + 1 - 2 * $j ))
    u=$(( $i / 2 ))
    w=$1  
    gawk '/^>/' $v >> $1_ir
      while [[ "$n" -le "$e" ]]
      do
        stem_ab
        n=$(( $n + 1 ))   
      done
        printf %s"\t"%0.f"\n" "The number of IR is:" $t >> $1_ir
        rm $v
  fi
done
rm $1_00
exit 0 ;
