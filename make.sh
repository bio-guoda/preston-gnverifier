#!/bin/bash
#
# Script to track resources used by https://verifier.globalnames.org
#



curl "http://opendata.globalnames.org/dwca/"\
 | grep -P -o "[0-9a-z-]+.(tar.gz|zip)"\
 | sed 's+^+http://opendata.globalnames.org/dwca/+g'\
 | xargs preston track
