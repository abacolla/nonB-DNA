# nonB-DNA
Get nonB DNA-forming sequences from fasta files. 
Usage: script.sh myfile.
myfile contains up to 100 fasta records obtained through the twoBitToFa utility, i.e. each header reads for example >chr1:1000-2000. Typically each fasta record is 1 - 10 kb but size may vary. You may experiment with various sizes.

Motivating Example:

Step 1 - get fasta sequence.
Given a file named "fastaList" containing 31 fasta records:
do:
twoBitToFa -noMask -seqList=fastaList hg38.2bit fastaList.fa
twoBitToFa may be obtained from the UCSC genome browser at http://hgdownload.cse.ucsc.edu/admin/exe and selecting the appropriate platform. hg38.2bit may be obtained from http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/.

Step 2 - run nonB DNA scripts
Option A - run all records serially
./dr_get.sh fastaList.fa (make sure dr_get.sh is executable - chmod 700 dr_get.sh)
Option B - run each record on separate processors in parallel (HPC cluster)
csplit -s -n 2 -f bin_ fastaList.fa '/^>/' '{*}' # get 31 files from bin_01 to bin_31

rm bin_00
./makeFile.sh h
./makeFile.sh z
./makeFile.sh g4
./makeFile.sh dr
./makeFile.sh ir
Submit job to scheduler as per HPC instructions with the following directive (for dr for example)
ibrun (or mpirun as per HPC instructions) vga_submitMpiJob dr_
Note1: for vga_submitMpiJob see c++ files
Note2: load the same modules (mpich and mvapich2) used to compile the c++ script
