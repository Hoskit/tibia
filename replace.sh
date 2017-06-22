#!/bin/bash

fileRegex="health now=\"[0-9+]\" max=\"([3-9][0-9]{3})\""
numberEndingRegex="[0-9]*;$"

for file in $(find . -name "monster/*/*.xml"); do
	while read line; do
    # is a fieldsize line
    if [[ $line =~ $fileRegex ]]
    then
      # capture the first group and multiply by 2
      oldNumber="${BASH_REMATCH[1]}"
      newNumber="$((oldNumber * 2));"

      echo $line | sed "s/$numberEndingRegex/$newNumber/g" #": " $item
    fi;
  done <$file
done;
done;