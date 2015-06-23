#! /bin/bash

#create dir for files
mkdir Human_WP
cd Human_WP
#download Human files
wget -O Homo%20sapiens.zip "http://www.wikipathways.org//wpi/batchDownload.php?species=Homo%20sapiens&fileType=gpml"
#wget -O Homo%20sapiens.zip "http://www.wikipathways.org//wpi/batchDownload.php?species=Homo%20sapiens&fileType=gpml&tag=Curation:AnalysisCollection"
unzip Homo%20sapiens.zip
#extract Gene IDs
for file in *gpml; do grep "Entrez" $file > out.txt; cut -d'"' -f4 out.txt > ${file}.txt; echo $file; done
cd ..
RScript download_Wikipathways.R
