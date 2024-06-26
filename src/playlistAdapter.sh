#!/bin/bash
# This script needs to be called with the playlist file as a cmdline parameter
# and referenced as <param name="program">playlistAdapter.sh</param> in the ices2 config
dir=$1
while [ ! -f "$currentline" ];
do
    currentlinecount=$(cat /home/admin/radioScripts/currentLine)
    linecount=$(wc -l $dir | cut -f1 -d' ')
    currentline=$(head -$currentlinecount $dir | tail -1)
    currentlinecount=$((currentlinecount + 1))
#    echo "$currentline lc: $linecount currentlinecount: $currentlinecount"
done

if [ $currentlinecount -gt $linecount ]
then
    currentlinecount=1
    shuf $dir > "${dir}.shuffled"
    cat "${dir}.shuffled" > $dir
fi

echo $currentlinecount > /home/admin/radioScripts/currentLine

#echo $linecount
#echo $currentlinecount

sh /home/admin/radioScripts/jsonFromM3u.sh $dir

# Writes currently playing song to this file
# This is a workaround for if Icy-Metadata isn't working
echo "{\"songs\": $(cat /var/www/radio/jsonFromM3u.json), \"current_line\": $currentlinecount, \"total_lines\": $linecount, \"next_up\": \"$(head -$((currentlinecount)) $dir | tail -1)\",  \"currently_playing\": \"$currentline\", \"song_info\": $(ffprobe -v quiet -print_format json -show_format -show_streams "$currentline")}" > "/var/www/radio/currentlyPlaying.json"
echo $currentline
