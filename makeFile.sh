#!/bin/bash

n=0
for i in bin*
do 
  echo -e '#!/bin/bash\n' > ${1}dna_${n}.sh
  echo -e "bash ${1}_get.sh ${i}\n\nexit 0" >> ${1}dna_${n}.sh; let ++n
done
