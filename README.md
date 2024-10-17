# nonB-DNA

* Synopsis: search for nonB DNA-forming sequences in fasta files. 

* Usage: script.sh myfile

* Note: myfile contains up to 1000 fasta records obtained through the twoBitToFa utility, i.e. each header reads, for example, >chr1:1000-2000. Typically each fasta record is 1 - 10 kb but size may vary.

* Motivating Example:

Step 1 - get fasta sequences.
Given a file named "fastaList" (see enclosed) containing 31 fasta coordinates:
do:
twoBitToFa -noMask -seqList=fastaList hg38.2bit fastaList.fa
twoBitToFa may be obtained from the [UCSC genome browser](http://hgdownload.cse.ucsc.edu/admin/exe) and selecting the appropriate platform. hg38.2bit may be obtained [here](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/).

Step 2 - run nonB DNA scripts
Option A - run serially
./dr_get.sh fastaList.fa (dr_get.sh must be executable - chmod 700 dr_get.sh)
Option B - run in parallel on multiple processors
do:
csplit -s -n 3 -f bin_ fastaList.fa '/^>/' '{*}' ; generates 31 files from bin_000 to bin_031

rm bin_000
./makeFile.sh h
./makeFile.sh z
./makeFile.sh g4
./makeFile.sh dr
./makeFile.sh ir
Submit job to scheduler as per HPC instructions (see launchJob.sh for an example) 
ibrun (or mpirun depending on HPC instructions) vga_submitMpiJob drdna_ # for vga_submitMpiJob see the submitMpi repository

Step 3 - process output
The output consists of a number of files containing:
chr number, hg38 coordinate, length, distance from start and end of sequence to center of fasta sequence, sequence (for dr, g4, z)
chr number, hg38 coordinate, length of stem, length of loop, distance from center loop to center of fasta sequence, sequence of both stems (for h, ir)
Use nonB_getRes.sh to extract the number of tracts - Usage: nonB_getRes.sh file_suffix(dr | ir | q1k | z1k | triplex).

* g4_cxx (C++Quad)

This directory contains C++ scripts to search for G4-forming repeats in genomes. Have a fasta file for each chromosome sequence (i.e. chr1.fa, chr2.fa, ...) and fill-in file vga_chrom_names.hpp with the chr list. Then when launching the g4_cxx binary it will automatically read the fasta files (one file per processor) in the current ditectory. 

## References

De-Paula et al. [Enriched G4 forming repeats in the human genome are associated with robust well-coordinated transcription and reduced cancer transcriptome variation](https://www.jbc.org/article/S0021-9258(24)02324-X/fulltext) *J. Biol. Chem.* **In Press**, 2024.

Fan et al. [Profiling human pathogenic repeat expansion regions by synergistic and multi‐level impacts on molecular connections](https://link.springer.com/article/10.1007/s00439-022-02500-6) *Hum. Genet.* **Online ahead of print**, 2022.

Chiacchia [Doubling Down](https://www.psc.edu/doubling-down/), Pittsburgh Supercomputing Center Science Highlights, 2020.

Seo et al. [Replication-based rearrangements are a common mechanism for SNCA duplication in Parkinson's disease](https://movementdisorders.onlinelibrary.wiley.com/doi/10.1002/mds.27998) *Mov. Disord.* **35**, 868-876, 2020.

Singer-Villalobos [Damaged DNA](https://www.xsede.org/-/damaged-dna) / [Damaged DNA](https://www.tacc.utexas.edu/-/damaged-dna), 2020.

Bacolla et al. [Cancer mutational burden is shaped by G4 DNA, replication stress and mitochondrial dysfunction](https://www.sciencedirect.com/science/article/pii/S0079610718302426?via%3Dihub) *Prog. Biophys. Mol. Biol.* **147**, 47-61, 2019.

Bacolla et al. [Translocation and deletion breakpoints in cancer genomes are associated with potential non-B DNA-forming sequences](https://academic.oup.com/nar/article/44/12/5673/2457502) *Nucleic Acids Res.* **44**, 5673-5688, 2016.
