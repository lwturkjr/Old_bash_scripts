#!/bin/bash

# Get what's playing in pianobar

if [ ! 'pgrep pianobar' ];

then
echo 'Pianobar is not running'

else
cat ~toast/.pianobar.out| grep 'by\|-'

fi
