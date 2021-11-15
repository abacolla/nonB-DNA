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
 * November 17, 2017
 *
 * g4_search01.cpp -- Implementation file to search for G4 DNA-forming sequences in fasta file
*/

#include "vga_g4Search.h"
#include <regex>

CreateG4::CreateG4(string inFile, string outFile)
	: inputFile{ inFile }, outputFile{ outFile }
{	
}

void CreateG4::ReadFile()
{
  ifstream f1;
  unsigned short pos1; //, pos2, pos3;
  f1.open(inputFile.c_str(), ios::in);
  if (f1.is_open())
    {
	cout << "Opening input file " << inputFile << endl;
	while (getline(f1, this->str))
	{
	  pos1 = str.find('>');
	  if (pos1 == 0)
	    {
	      this->fileHead = str;
	    }
	else
  	  {
	    this->fileSeq += str;
	  }
	}
       this->fileChr = fileHead.substr(1);
       cout << "Length of sequence: " << fileSeq.size() << " for file " << inputFile << endl;
    }
    else
      {
	cerr << "Unable to open " << inputFile << endl;
      }
  f1.close();
}

void CreateG4::GetDisplayData() const
{
    ofstream f2;
    f2.open(outputFile.c_str(), ios::out);
    if (f2.is_open())
	{
        cout << "Opening output file " << outputFile << endl;
        size_t maxG4Length, minG4Length, G4Length;
	    unsigned long long start, end, i;
	    string G4Seq;
	    maxG4Length = 90;
	    minG4Length = 17;
	    start = 0;
	    end = fileSeq.size() - maxG4Length;
        regex g4Pattern("(((G|g){3}[ACGTacgt]{1,7}){3,}(G|g){3})||(((C|c){3}[ACGTacgt]{1,7}){3,}(C|c){3})");
        for (i = start; i < end; ++i)
        {
            for (G4Length = maxG4Length; G4Length >= minG4Length; --G4Length) 
            {
                G4Seq = fileSeq.substr(i, G4Length);
                if (regex_match(G4Seq, g4Pattern))
                {
                    f2 << fileChr << '\t' << i + 1 << '\t' << G4Seq.size() << '\t' << G4Seq << '\t' << endl;
                    i = i + G4Seq.size();
                }
            }
        }
		for (i = end + 1; i < fileSeq.size() - minG4Length; ++i)
		{
			maxG4Length--;
			for (G4Length = maxG4Length; G4Length >= minG4Length; --G4Length)
			{
				G4Seq = fileSeq.substr(i, G4Length);
				if (regex_match(G4Seq, g4Pattern))
				{ 
					f2 << fileChr << '\t' << i + 1 << '\t' << G4Seq.size() << '\t' << G4Seq << '\t' << endl;
					i = i + G4Seq.size();
					if (i > fileSeq.size() - minG4Length + 1)
					{
						break;
					}
				}
			}
		}
    }
    else
    {
        cerr << "Unable to write to  " << outputFile << endl;
    }
    f2.close();
}
