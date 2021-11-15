
#!/bin/bash

# run getFasta.sh
# run makeMfoldFile.sh

csplit -s -n 5 -f $1_ $1 '/^>/' '{*}'
rm ${1}_00000

for v in ${1}_[0-9][0-9][0-9][0-9][0-9]
do
  if [[ -s $v ]]
  then
    header=`sed -n '1p' $v | sed -e 's/^>//'`
    mfold SEQ=$v NA=DNA > /dev/null 2>&1 > ${v}.txt
    delG=`grep "Minimum" ${v}.txt | sed 's/Minimum folding energy is //; s/ kcal\/mol\.//'`
    if [[ -z $delG ]] || grep "N" $v
    then
      printf "%s\tN\n" $header >> $1_mfold
    else
      printf "%s\t%s\n" $header $delG >> $1_mfold
    fi
  fi
  rm $v*
done

exit 0;
