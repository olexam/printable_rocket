#!/bin/bash
#

for file in ./src/scad/*.scad; do
    file="${file##*/}"
    stlFile="${file%.*}.stl"
    if [ "$file" == "RocketAssembly.scad" ] ; then
        continue;
    fi
    echo ">>> process $file -> $stlFile"
    openscad -o stl/$stlFile -D 'quality="production"' src/scad/$file &
done

wait;
