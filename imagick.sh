#!/bin/bash
#другая справка
if [ "$1" == "-h" ] || [ "$1" == "-help" ]; then
        echo $'\nUsage: ./imagick.sh <directory> <width> <height> <output_directory>'
        echo $'\t<directory>: directory with pictures to resize'
        echo $'\t<width>: minimal width to set'
        echo $'\t<height>: minimal height to set'
        echo $'\t<output_directory>: directory for storing resized pictures'
        exit 0
fi
if [ -z $1 ]; then
        echo $'\nNo argumets passed!'
        echo $'Type ./imagick.sh -h or ./imagick.sh -help in order to get manual'
        exit 1
elif [ -z $2 ]; then
        echo $'\nTarget width missed!'
        echo $'Type ./imagick.sh -h or ./imagick.sh -help in order to get manual'
        exit 1
elif [ -z $3 ]; then
        echo $'\nTarget height missed!'
        echo $'Type ./imagick.sh -h or ./imagick.sh -help in order to get manual'
        exit 1
elif [ -z $4 ]; then
        echo $'\nOutput directory name missed!'
fi

if [ ! -d $1 ]; then
        echo $'\nInput directory does not exists'
        exit 1
fi

OUT_DIRECTORY=$4
if [ ! -d "$OUT_DIRECTORY" ]; then
        mkdir "$OUT_DIRECTORY"
fi

for img in $1/*.jpg; do
        width=$(identify -format '%w' $img)
        height=$(identify -format '%h' $img)

        filename=$(basename $img)
        if [ "$width" -gt "$2" ] || [ "$heigth" -gt "$3" ]; then
                convert $img -resize "$2x$3" "$OUT_DIRECTORY/$filename"
        else mv $img "$OUT_DIRECTORY/$filename"
        fi;
done