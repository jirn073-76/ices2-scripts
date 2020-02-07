#!/bin/bash
# Enters specified directory in cmdline and creates a .m3u file from its contents
cd $1
ls -1v -d $PWD/* |grep .ogg > /tmp/playlist.m3u && mv /tmp/playlist.m3u .  
