#!/bin/bash
findNameMusic(){ 
    filecopy=$(cat name.txt)
    nameArtist=$(cat name.txt)
    exiftool -Artist "$nameArtist" > text.txt
    nameArtist=$(cat text.txt)
    cut -d ":" -f2- <<< $nameArtist > Artist.txt
    finalname=$(cat Artist.txt)
    finalname=${finalname//[[:blank:]]/}
    if [ "$finalname" != "" ];then
        if [ ! -d "$finalname" ];then
            mkdir "$finalname"
        fi
    fi
    if [ "$finalname" != "" ];then
        mv "$filecopy" "$finalname"
    fi
    rm text.txt Artist.txt
}

find . -type f -name "*.mp3" > musicfind.txt
file="musicfind.txt"
while read -r line; do
    echo "$line" | cut -c 3- > name.txt
    findNameMusic "$line" 
done <$file 
    
rm name.txt musicfind.txt
