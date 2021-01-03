# nonB-DNA
Get nonB DNA-forming sequences from fasta files. 
Usage: script.sh myfile.
myfile contains up to 100 fasta records obtained through the twoBitToFa utility, i.e. each header reads for example >chr1:1000-2000. Typically each fasta record is 1 - 10 kb but size may vary. You may experiment with various sizes.
Example: given a file named "fastaList" containing
chr16:78535654-78545654
chr16:78545654-78555654
chr16:78555654-78565654
chr16:78565654-78575654
chr16:78575654-78585654
...
do:
twoBitToFa -noMask -seqList=fastaList hg38.2bit fastaList.fa
twoBitToFa may be obtained from the UCSC genome browser at http://hgdownload.cse.ucsc.edu/admin/exe and selecting the appropriate platform. hg38.2bit may be obtained from http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/.


