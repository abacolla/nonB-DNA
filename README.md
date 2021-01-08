# nonB-DNA
Get nonB DNA-forming sequences from fasta files. 
Usage: script.sh myfile.
myfile contains up to 100 fasta records obtained through the twoBitToFa utility, i.e. each header reads for example >chr1:1000-2000. Typically each fasta record is 1 - 10 kb but size may vary. You may experiment with various sizes.

Motivating Example:

Step 1 - get fasta sequence.
Given a file named "fastaList" containing 31 fasta records:
chr16:78815000-78825000
chr16:78825000-78835000
chr16:78835000-78845000
chr16:78845000-78855000
chr16:78855000-78865000
chr16:78865000-78875000
chr16:78875000-78885000
chr16:78885000-78895000
chr16:78895000-78905000
chr16:78905000-78915000
chr16:78915000-78925000
chr16:78925000-78935000
chr16:78935000-78945000
chr16:78945000-78955000
chr16:78955000-78965000
chr16:78965000-78975000
chr16:78975000-78985000
chr16:78985000-78995000
chr16:78995000-79005000
chr16:79005000-79015000
chr16:79015000-79025000
chr16:79025000-79035000
chr16:79035000-79045000
chr16:79045000-79055000
chr16:79055000-79065000
chr16:79065000-79075000
chr16:79075000-79085000
chr16:79085000-79095000
chr16:79095000-79105000
chr16:79105000-79115000
chr16:79115000-79125000
do:
twoBitToFa -noMask -seqList=fastaList hg38.2bit fastaList.fa
twoBitToFa may be obtained from the UCSC genome browser at http://hgdownload.cse.ucsc.edu/admin/exe and selecting the appropriate platform. hg38.2bit may be obtained from http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/.

Step 2 - run nonB DNA scripts
Option A - run all records serially
./dr_get.sh fastaList.fa (make sure dr_get.sh is executable - chmod 700 dr_get.sh)
Option B - run each record on separate processors in parallel
csplit -s -n 2 -f bin_ fastaList.fa '/^>/' '{*}'# get 31 files from bin_01 to bin_31

rm bin_00
./makeFile.sh h
./makeFile.sh z
./makeFile.sh g4
./makeFile.sh dr
./makeFile.sh ir







