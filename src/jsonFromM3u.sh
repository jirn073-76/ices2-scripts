#!/bin/bash
dir=$1
ind=1
tmpDir="/tmp/jsonFromM3u.tmp"
touch $tmpDir
echo "{\"songlist\": [" > $tmpDir

while IFS= read -r line
do
  echo "\"$ind: $line\"," >> $tmpDir
  ind=$(($ind+1))
done < "$dir"
sed -i '$ s/.$//' $tmpDir
echo "]}" >> $tmpDir

cp /tmp/jsonFromM3u.tmp /var/www/radio/jsonFromM3u.json
