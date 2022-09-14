#!/bin/bash
#
# Script to track resources used by https://verifier.globalnames.org
#

function track_script {
# first track this script
  preston track "file://$PWD/$0"
}

function track_content {
  # then track the content
  preston track "http://opendata.globalnames.org/dwca/"\
  | grep "hash://sha256"\
  | preston cat\
  | grep -P -o "[0-9a-zA-Z-]+.(tar.gz|zip)"\
  | sed 's+^+http://opendata.globalnames.org/dwca/+g'\
  | xargs preston track
}

function generate_readme {
  
  echo -e "This publication contains a Preston archive of resources used by Global Names Verifier (https://verifier.globalnames.org/about)." > README.md
  echo -e "\n\nPlease follow academic citation guidelines when using this corpus." | tee -a README.md
  echo -e "\n\nTo clone this archive:"\
  | tee -a README.md

  echo -e "\n\n$ preston clone"\
  | tee -a README.md

  echo -e "\n\nAfter cloning this archive, you should be able to reproduce results below without the --remote https://zenodo.org... part."\
  | tee -a README.md

  echo -e "\n\n$ preston history\n\n"\
  | tee -a README.md

  preston history\
  | tee -a README.md

  echo -e "\n\nResource Alias/References\n\n$ preston alias -l tsv | cut -f1 | sort | uniq\n\n" | tee -a README.md
  
  preston alias -l tsv\
  | cut -f1\
  | sort\
  | uniq\
  | tee -a README.md

  # build the citation list
  echo -e "\n\nReferences\n\n"\
  | tee -a README.md

  echo generating citation list
  preston ls\
  | preston cite\
  | sort\
  | uniq\
  | tee -a README.md
}

track_script
track_content
generate_readme
