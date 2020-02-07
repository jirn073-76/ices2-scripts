#!/bin/bash
# This script needs to be called with the playlist file as a cmdline parameter
# and referenced as <param name="program">playlistAdapter.sh</param> in the ices2 config

dir=$1
currentlinecount=$(cat /home/admin/radioScripts/currentLine)
linecount=$(wc -l $dir | cut -f1 -d' ')
currentline=$(head -$currentlinecount $dir | tail -1)
currentlinecount=$((currentlinecount + 1))

if [ $currentlinecount -gt $linecount ]
then
    currentlinecount=1
    shuf $dir > "${dir}.shuffled"
    $(mv "${dir}.shuffled" $dir)
fi

sed -i "s/[0-9]*/$currentlinecount/g" currentLine

#echo $linecount
#echo $currentlinecount

# Writes currently playing song to this file
# This is a workaround for if Icy-Metadata isn't working

$(echo $currentline > /var/www/radio/currentlyPlaying)
echo $currentline
