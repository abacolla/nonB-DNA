/*
 * Albino Bacolla
 * Research Investigator
 * The University of Texas MD Anderson Cancer Center
 * Department of Cellular and Molecular Oncology
 * 6767 Bertner Avenue
 * Houston, TX 77030
 * Tel:  +1 (713) 745-5210
 * Cell: +1 (346) 234-5002
 * Email abacolla@mdanderson.org
 *
 * November 1, 2017
 *
 * g4_search01.h -- Header file to search for G4 DNA-forming sequences in fasta file
 * */

#pragma once
#include <string>
#include <fstream>
#include <iostream>

using namespace std;

class CreateG4
{
public:
  CreateG4() = default;
  CreateG4(string inFile, string outFile);
  ~CreateG4() = default;
  void ReadFile();
  void GetDisplayData() const;

private:
  string inputFile, outputFile, str, fileHead, fileChr, fileSeq;
};
