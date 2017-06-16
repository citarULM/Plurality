#!/bin/bash

# Works with singularity 2.3
# Customizes a base container image by a given definition file

SHUB_URL="shub://c1t4r/CiTAR-Containers"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 custom-container-dir"
    exit
fi

INPUTDIR="$1"
CONTAINERNAME="$(cat $INPUTDIR/containername)".img
FILELIST="$INPUTDIR/filelist"
DUF="$INPUTDIR/du"

echo "Downloading latest JUSTUS base container"
singularity pull --name "$CONTAINERNAME" $SHUB_URL

if [[ -f $DUF ]]; then
    echo "Using predefined additional size information"
    DU="$(cat $DUF)"
else
    echo "Estimating additional size needed"
    DU=`du -m -c $(cat $FILELIST | sed 's/#.*//') | awk '/total/{printf("%s ",$1)}'`
    echo "$DU" > "$DUF"
fi

echo "${DU}Mb needed in addition, expanding the container..."
singularity expand --size $DU "$CONTAINERNAME"

