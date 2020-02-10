#!/bin/bash
dir=$1
ind=1
tmpDir=`mktemp`
touch $tmpDir
echo "{\"songlist\": [" > $tmpDir

while IFS= read -r line
do
  echo "{\"index\": \"$ind\", \"filename\": \"$line\"}," >> $tmpDir
  ind=$(($ind+1))
done < "$dir"
sed -i '$ s/.$//' $tmpDir
echo "]}" >> $tmpDir
cat $tmpDir > /var/www/radio/jsonFromM3u.json
