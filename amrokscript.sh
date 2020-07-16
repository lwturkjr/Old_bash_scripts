##########################################################################
# This Script displays the artist, album and song title
# of the current song paying in amarok to be used with conky or w/e
# script By: toast
# for when i didn't like the other peoples scripts that do the same thing.
##########################################################################

nowplaying=`qdbus org.kde.amarok /Player GetMetadata`

if [ $? = 0 ] && [ -n "$nowplaying" ]; then

   album=`qdbus org.kde.amarok /Player GetMetadata | awk -F: '/album\:/{print $2}'`
   artist=`qdbus org.kde.amarok /Player GetMetadata | awk -F: '/albumartist/{print $2}'`
   song=`qdbus org.kde.amarok /Player GetMetadata | awk -F: '/title/{print $2}'`


fi
   expr substr "$artist -$song" 1 200
   expr substr "$album" 1 200
