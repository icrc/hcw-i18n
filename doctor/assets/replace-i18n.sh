#!/bin/bash

set -e

cd "$(dirname "$0")" || exit


echo "Checking translation in $(dirname $0)"

for file in ??.json ; do
  basename=$(echo "${file/.json/}")
  filename=$(basename "${file}")
  lang=${filename/.json/}
  rm -f replace-i18n.sh.json
  rm -f i18n-override.json
  if [ "${basename}" != "template" ] ; then
    echo "Checking ${filename}"
    if [ -f "i18n-override/${basename}.json" ]; then
      echo "Validate file ${basename}.json"
      cat "i18n-override/${basename}.json" | jq -e
      echo "Copy and sort original file in ${basename}.json.orig"
      cat "${basename}".json | jq --sort-keys > "${basename}".json.orig
      cat "i18n-override/${basename}.json" | jq --sort-keys > ${basename}.json
    fi
  fi
done