#!/bin/bash

#SBATCH -J dr_1		            				        # Job name
#SBATCH -o dr_1.%j.out      					        # Name of stdout output file (%j expands to jobId)
#SBATCH -e dr_1.%j.err							          # Error file
#SBATCH -p normal   	      					        # Queue name
#SBATCH -N 2                  					      # Total number of nodes requested
#SBATCH -n 31                 					      # Total number of mpi tasks requested
#SBATCH -t 01:30:00.              		  			# Run time (hh:mm:ss)
#SBATCH --mail-user=abacolla@mdanderson.org	  # Address email notifications
#SBATCH --mail-type=all                       # Email at begin and end of job
##SBATCH -A TG-MCB170053      					      # Allocation name to charge job against

	# Echo commands to std out
set -x

  # load modules
module load remora intel/18.0.2 impi/18.0.2

echo "Run on stampede2: `date`"

  # launch job
remora ibrun vga_submitMpiJob drdna_

echo "Done: `date`"
exit 0;
