#!/usr/bin/env bash

#unzip file
localpath=$(pwd)
echo "Local path: $localpath"

downloadpath="$localpath/download"
echo "Download path: $downloadpath"
cd $downloadpath;

zipfile=(*)
echo $zipfile
unzip "$downloadpath/$zipfile"

tsv_file=$(ls | grep ".tsv$")
echo $tsv_file

# run convertion to parquet
cd $localpath

# make brick folder
brickpath="$localpath/brick"
echo "Brick path: $brickpath"
mkdir -p "$brickpath"

python3 ./stages/bindingDB2parquet.py $downloadpath/$tsv_file $brickpath