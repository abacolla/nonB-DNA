# nonB-DNA
Synopsis: search for nonB DNA-forming sequences in fasta files. 

Usage: script.sh myfile

Note: myfile contains up to 1000 fasta records obtained through the twoBitToFa utility, i.e. each header reads, for example, >chr1:1000-2000. Typically each fasta record is 1 - 10 kb but size may vary.

Motivating Example:

Step 1 - get fasta sequences.
Given a file named "fastaList" (see enclosed) containing 31 fasta coordinates:
do:
twoBitToFa -noMask -seqList=fastaList hg38.2bit fastaList.fa
twoBitToFa may be obtained from the UCSC genome browser at http://hgdownload.cse.ucsc.edu/admin/exe and selecting the appropriate platform. hg38.2bit may be obtained from http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/.

Step 2 - run nonB DNA scripts
Option A - run serially
./dr_get.sh fastaList.fa (dr_get.sh must be executable - chmod 700 dr_get.sh)
Option B - run in parallel on multiple processors
do:
csplit -s -n 2 -f bin_ fastaList.fa '/^>/' '{*}' # generates 31 files from bin_00 to bin_31

rm bin_00
./makeFile.sh h
./makeFile.sh z
./makeFile.sh g4
./makeFile.sh dr
./makeFile.sh ir
Submit job to scheduler as per HPC instructions (see launchJob.sh for an example) 
ibrun (or mpirun depending on HPC instructions) vga_submitMpiJob drdna_ # for vga_submitMpiJob see the submitMpi repository

Step 3 - process output
The output consists of:
chr number, hg38 coordinate, length, distance from start and end of sequence to center of fasta sequence, sequence (dr, g4, z)
chr number, hg38 coordinate, length of stem, length of loop, distance from center loop to center of fasta sequence, sequence of both stems (h, ir)


