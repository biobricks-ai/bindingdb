#!/bin/bash

# Fetch the HTML content
html_content=$(curl -s "https://www.bindingdb.org/rwd/bind/chemsearch/marvin/Download.jsp#")

# Find the MySQL DB link and extract the value following download_file=
download_link=$(echo "$html_content" | grep -o 'download_file=[^"]*' | grep 'BDB_my' | sed 's/download_file=//')

# Print the result to the terminal
echo "MySQL DB download link: $download_link"

# Save the result to the file
full_download_link="https://www.bindingdb.org/bind/downloads$download_link"
echo "$full_download_link" > download/download_link.txt
