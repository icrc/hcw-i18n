#!/bin/bash

set -e
# This script will start docker services and copy initial i18n files for HCW Docker images.

# copy file from docker service to the related i18n folder
move_files() {
   local service=$1
   local docker_path=$2
   local tmp_folder="./${service}/assets/i18n-temp"
   local i18n_folder="./${service}/assets/i18n-override"
   rm -rf "${tmp_folder}"
   docker compose cp "${service}":"${docker_path}" "${tmp_folder}"
   docker compose cp "${service}":/tmp/orig "${tmp_folder}"
   cp "${tmp_folder}"/*.json "${i18n_folder}"
   cp "${tmp_folder}"/orig/*.orig "${i18n_folder}"
   rm -rf "${tmp_folder}"

}

docker compose up -d --build
move_files "doctor" "/usr/share/nginx/html/assets/i18n/"
move_files "patient" "/usr/share/nginx/html/assets/i18n/"
move_files "backend" "/usr/src/app/config/locales/"
# not done as admin is not yet translated.
move_files "admin" "/usr/share/nginx/html/assets/translate/"


#check-and-replace-i18n-resources.sh