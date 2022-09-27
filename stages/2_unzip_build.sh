#!/usr/bin/env bash

#unzip file
localpath=$(pwd)
echo "Local path: $localpath"

temppath="$localpath/temp"
echo "Temporal path: $temppath"
cd $temppath;

files=(*)
unzip "$temppath/$files"

# run convertion to parquet
cd "./../";
filename="${files%.*}"
python3 "bindingDB2parquet.py $temppath/$filename ./brick.parquet"