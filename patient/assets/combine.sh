#!/bin/bash

## This script combine the language files
# simply create a file <lang>.override.json and the overridden language


cd "$(dirname "$0")" || exit


echo "Updating translation in $(dirname $0)"

for file in ??.json ; do
  basename=$(echo "${file/.json/}")
  filename=$(basename "${file}")
  lang=${filename/.json/}
  rm -f combine.sh.json
  rm -f i18n-override.json
  if [ "${basename}" != "template" ] ; then
    echo "Checking ${filename}"
    if [ -f "i18n-override/${basename}.json" ]; then
      echo "Copy original file in ${basename}.json.orig"
      mv "${basename}".json "${basename}".json.orig
      jq --argfile f2 "${basename}.json.orig" '. as $f1 | $f2 | with_entries(if $f1[.key] != null then . + {value: $f1[.key]} else . end)' "i18n-override/${basename}.json" > "${basename}.json"; ret=$?
      if [ ${ret} = 0 ] ; then
        echo "Lang ${lang} combined successfully"
      else
        echo "Error during combining lang ${lang}, check if json is valid"
        exit 1
      fi
    fi
  fi
done