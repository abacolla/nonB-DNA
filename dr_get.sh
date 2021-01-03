#!/bin/bash
# dr1k_get.sh -- find tandem repeats (DR) k>=3 to 100 in fasta files

# $1 = target fasta file
# a = query DNA sequence stripped of new lines
# b = DNA sequence of tandem repeats (DR)
# c = distance beginning DR motif from breakpoint
# d = distance end DR from breakpoint
# e = adjusted DNA sequence length
# f = DR length
# g = DNA sequence from b+1 to end
# h = value of BASH_REMATCH 
# i = DNA sequence length
# j = minimum DR unit length
# k = maximum DR unit length
# n = start position DR motif - NOTE n + p is now adjusted compared to previous scripts to match UCSC browser (date 120814)
# o = chr number
# p = start position DNA sequence
# q = end position DNA sequence
# t = number of DRs
# u = breakpoint position
# v = loop through fasta files
# w = file redirection

  # Step 1 -- Define Functions
 
function stem_ab () {
for ((f=k; f>=j; --f))
do
  b=${a:n:f}
  g=${a:n+f}
  if [[ $b != [N]* && $g =~ ^($b){4,} ]] 
  then
    h=$BASH_REMATCH
    c=$(( $n - $u + 1 ))
    d=$(( $c + ${#h} + ${#b} - 1 ))
    printf %s"\t"%.0f"\t"%g"\t"%g"\t"%g"\t"%s"\n" $o `expr $n + $p + 1` `expr ${#b} + ${#h}` $c $d $b$h >> ${w}_dr
    n=$(( $n + $f + ${#h} - 1 ))
    t=$(( $t + 1 ))
    break
  fi  
done
}

  # Step 2 -- Body 
csplit -s -n 2 -f $1_ $1 '/^>/' '{*}'
for v in ${1}_[0-9][0-9]
do
  if [[ -s $v ]]
  then
    j=3; k=100; n=0; t=0  
    a="`awk '!/^>/ { printf "%s", $0 }; END { printf "%s", "\n" }' $v`"
    o=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f2`
    p=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f3`
    q=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f4`
    i=$(( $q - $p + 1 ))
    e=$(( $i + 1 - $j * 5 ))
    u=$(( $i / 2 ))
    w=$1  
    awk '/^>/' $v >> $1_dr
      while [[ "$n" -le "$e" ]]
      do
        stem_ab
        n=$(( $n + 1 ))   
      done
        printf %s"\t"%.0f"\n" "The number of DR is:" $t >> $1_dr
        rm $v
  fi
done
rm $1_00
exit 0 ;
