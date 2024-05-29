#!/bin/bash

## This script combine the language files
# simply create a file <lang>.override.json and the overrided language

folder=$(dirname $0)

for file in ${folder}/??.json ; do
  basename=$(echo "${file/.json/}")
  filename=$(basename "${file}")
  lang=${filename/.json/}
  if [ "${basename}" != "template" ] ; then
    echo "Keep original file in ${basename}.orig.json"
    cp "${basename}".json "${basename}".orig.json
  fi
  if [ -f "${basename}".override.json ] ; then
    jq -s '.[0] * .[1]' "${basename}".json "${basename}".override.json > "${basename}".combined.json ; ret=$?
    if [ ${ret} = 0 ] ; then
      mv "${basename}".combined.json "${basename}".json
      rm "${basename}".override.json
      echo "Lang ${lang} combined successfully"
    else
      echo "Error during combining lang ${lang}, check if json is valid"
      exit 1
    fi
  else
    echo "Nothing to combine for lang ${lang}"
  fi
done
