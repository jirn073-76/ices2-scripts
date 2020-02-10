#!/bin/bash
dir=$1
currentline="sentinel.file.should.not.exist"
o_linecount=$(cat /var/www/radio/currentlyPlaying.json | awk -F=":" -v RS="," '$1~/"current_line"/ {print}' | sed 's/\"current_line\"://g;s/\"//g;s/{//g;s/^ *//g')
o_currentline=$(cat /var/www/radio/currentlyPlaying.json | awk -F=":" -v RS="," '$1~/"currently_playing"/ {print}' | sed 's/\"currently_playing\"://g;s/\"//g;s/^ *//g')

while [ ! -f "$currentline" ];
do
    currentlinecount=$(cat /home/admin/radioScripts/currentLine)
    linecount=$(wc -l $dir | cut -f1 -d' ')
    currentlinecount=$((currentlinecount - 1))
    if [ $currentlinecount -lt 1 ]
    then
        currentlinecount=$linecount
    fi
    currentline=$(head -$currentlinecount $dir | tail -1)
done

echo $currentlinecount > /home/admin/radioScripts/currentLine

echo "{\"songs\": $(cat /var/www/radio/jsonFromM3u.json), \"current_line\": $currentlinecount, \"total_lines\": $linecount, \"next_up\": \"$(head -$((currentlinecount)) $dir | tail -1)\",  \"currently_playing\": \"$o_currentline\", \"song_info\": $(ffprobe -v quiet -print_format json -s$echo $currentline")}" > "/var/www/radio/currentlyPlaying.json"
