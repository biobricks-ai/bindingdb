#!/usr/bin/env bash

# Download file

localpath=$(pwd)
echo "Local path: $localpath"

downloadpath="$localpath/download"
echo "Download path: $downloadpath"
mkdir -p "$downloadpath"

# download file
file2download="BindingDB_All_2022m8.tsv.zip" # need to be changed with the new version
url_file="https://www.bindingdb.org/bind/downloads/$file2download"

# wget file to bindingdb_all.tsv.zip
wget "$url_file" -O "$downloadpath/bindingdb_all.tsv.zip"
