
#!/bin/bash

n=0
for i in chr*.fa ; do echo -e '#!/bin/bash\n' > file_${n}.sh; echo -e "vga_mfold.sh $i" >> file_${n}.sh; let ++n ; done

