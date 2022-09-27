#!/usr/bin/env bash

# Download file

localpath=$(pwd)
echo "Local path: $localpath"

temppath="$localpath/temp"
echo "Temporal path: $temppath"
mkdir -p $temppath
cd $temppath;

# download file
file2download="BindingDB_All_2022m8.tsv.zip" # need to be chamge with new version
url_file="https://www.bindingdb.org/bind/downloads/$file2download"
wget $url_file

