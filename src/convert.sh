#!/bin/bash
# This script converts all audio files in the execution directory to .ogg libvorbis encoded files with a 320k bitrate
# Also removes .flac extensions
find . -type f -name "*.*" -exec bash -c 'FILE="$1"; ffmpeg -i "${FILE}" -vn -c:a libmp3lame -ab 320k -y "${FILE%.flac}.mp3";' _ '{}' \;
