#!/usr/bin/env bash

downloadlink=$(cat download/download_link.txt)
echo "Downloading MySQL DB from $downloadlink" 
wget "https://www.bindingdb.org/bind/BDB_my-202307.tar" -O "download/mysql.tar"

# import dumped file
mkdir -p download/sqldump
tar -xvf ./download/mysql.tar -C ./download/sqldump