
/*
Albino Bacolla
Research Investigator
The University of Texas MD Anderson Cancer Center
Department of Cellular and Molecular Oncology
6767 Bertner Avenue
Houston, TX 77030
Tel:  +1 (713) 745-5210
Cell: +1 (346) 234-5002
Email abacolla@mdanderson.org

November 1, 2017

main.cpp -- Instantiate object to search for G4 DNA-forming sequences in one (large) fasta file
            The program processes ~1 x 10e6 bp / min
*/

#include <sstream>
#include <iomanip>
#include <mpi.h>
#include <ctime>
#include "vga_g4Search.h"
#include "vga_chrom_names.hpp"
using namespace chrom_names;

int main(int argc, char* argv[])
{
  clock_t t = clock();
  MPI_Init(&argc, &argv);
  int size, rank;
  MPI_Comm comm;
  comm = MPI_COMM_WORLD;
  MPI_Comm_size(comm, &size);
  MPI_Comm_rank(comm, &rank);

    /* STEP 1 - Provide name of input and output files */

  stringstream s1;
  s1 << v1[rank].c_str() << ".fa";
  stringstream s2;
  s2 << v1[rank].c_str() << "_G4_0.txt";

    /* STEP 2 - Create instance of Class 
                s1 = input file with 1 fasta sequence (full chromosome)
                s2 = output file with G4 sequences */

  CreateG4 search1(s1.str(), s2.str());
                                             
    /* STEP 3 - Read input files */

  search1.ReadFile();

    /* STEP 4 - Process files and output data */

  search1.GetDisplayData();

  t = clock() - t;
  double t1 = ((float)t/CLOCKS_PER_SEC/3600);
// cout << "Job executed by TainerLab on  " << ctime(&currTime) << endl;
  cout << "Processor " << rank << " finished file " << s1.str() << " in " << t1 << " hours; " << endl;

  MPI_Finalize();

  return 0;
}
