#!/bin/bash
#
# Script to track resources used by https://verifier.globalnames.org
#

# first track this script
preston track "file://$PWD/$0"

# then track the content
preston track "http://opendata.globalnames.org/dwca/"\
 | grep "hash://sha256"\
 | preston cat\
 | grep -P -o "[0-9a-zA-Z-]+.(tar.gz|zip)"\
 | sed 's+^+http://opendata.globalnames.org/dwca/+g'\
 | xargs preston track
