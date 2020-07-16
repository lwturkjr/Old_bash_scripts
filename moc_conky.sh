#!/bin/bash
# ===================================================== #
# Display MoC info in conky.                            #
# This is a modified version of a script availble here. #
# http://19eightseven.wordpress.com/tag/conky/          #
# Add this line to your ~/.conkyrc                      #
# ${exec /path/to/script/moc_conky.sh |fold -w55}.      #
# ===================================================== #

INFO=`mocp --info`

if [ "$INFO" = "State: STOP" ];
then

echo -n " "

else

Artist=`mocp --info |awk -F: '/Artist/{print $2}'`
Song=`mocp --info |awk -F: '/SongTitle/{print $2}'`
TotalTime=`mocp --info |awk -F: '/TotalTime/{print $2 ":" $3}'`
CurrentTime=`mocp --info |awk -F: '/CurrentTime/{print $2 ":" $3}'`
BitRate=`mocp --info |awk -F: '/Bitrate/{print $2}'`

expr substr "$Artist - $Song " 1 200
expr substr "$CurrentTime / $TotalTime    $BitRate" 1 200

fi
