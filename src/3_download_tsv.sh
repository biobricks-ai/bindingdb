#!/bin/bash

# Fetch the HTML content
html_content=$(curl -s "https://www.bindingdb.org/rwd/bind/chemsearch/marvin/Download.jsp")

# Find the BindingDB_All_{xxx}_.tsv.zip filename
filename=$(echo "$html_content" | grep -o 'BindingDB_All_[0-9]*_tsv.zip' | head -n 1)

# Construct the full download link
full_download_link="https://www.bindingdb.org/bind/downloads/$filename"

# Download the file and save it as bdb.tsv.zip
curl -o download/bdb.tsv.zip "$full_download_link"

# Optionally, print a message indicating the download is complete
echo "File downloaded to bdb.tsv.zip"