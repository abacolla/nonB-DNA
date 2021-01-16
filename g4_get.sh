#!/bin/bash
# g4_get.sh -- find G4_DNA-forming motifs in fasta files

# $1 = target fasta file
# a = query DNA sequence stripped of new lines
# b = DNA sequence g4-dna-forming repeat
# c = distance beginning G4_DNA motif from breakpoint
# d = distance end G4_DNA motif from breakpoint
# e = adjusted DNA sequence length
# f = g4-dna-forming repeat length
# i = DNA sequence length
# j = minimum G4-DNA length
# k = maximum G-DNA length
# n = start position G4-DNA motif
# o = chr number
# p = start position DNA sequence
# q = end position DNA sequence
# t = number of G4-DNA-forming repeats
# u = breakpoint position
# v = loop through fasta files
# w = file redirection

  # Step 1 -- Define Functions
 
function stem_ab () {
for ((f=k; f>=j; --f))
do
  b=${a:n:f}
  if [[ $b =~ ^(GGG[ACGT]{1,7}){3,}GGG$ || $b =~ ^(CCC[ACGT]{1,7}){3,}CCC$ ]] 
  then
    c=$(( $n - $u + 1 ))
    d=$(( $c + ${#b} - 1 ))
    printf %s"\t"%.0f"\t"%g"\t"%g"\t"%g"\t"%s"\n" $o `expr $n + $p` ${#b} $c $d $b >> ${w}_q1k
    n=$(( $n + $f - 1 ))
    t=$(( $t + 1 ))
    break
  fi  
done
}

  # Step 2 -- Body 
csplit -s -n 3 -f $1_ $1 '/^>/' '{*}'
for v in ${1}_[0-9][0-9][0-9]
do
  if [[ -s $v ]]
  then
    j=15; k=90; n=0; t=0  
    a="`awk '!/^>/ { printf "%s", $0 }; END { printf "%s", "\n" }' $v`"
    o=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f2`
    p=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f3`
    q=`grep ">" $v | tr '>:-' ' ' | cut -d ' ' -f4`
    i=$(( $q - $p + 1 ))
    e=$(( $i + 1 - $j ))
    u=$(( $i / 2 ))
    w=$1  
    awk '/^>/' $v >> $1_q1k
      while [[ "$n" -le "$e" ]]
      do
        stem_ab
        n=$(( $n + 1 ))   
      done
        printf %s"\t"%.0f"\n" "The number of G4-DNA-Forming Repeats is:" $t >> $1_q1k
        rm $v
  fi
done
rm $1_000
exit 0 ;
