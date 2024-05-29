#!/bin/bash
# This script will start docker services and copy initial i18n files for HCW Docker images.

# copy file from docker service to the related i18n folder
move_files() {
   local service=$1
   local docker_path=$2
   local tmp_folder="./${service}/assets/i18n-temp"
   local i18n_folder="./${service}/assets/i18n"
   rm -rf "${tmp_folder}"
   docker compose cp "${service}":"${docker_path}" "${tmp_folder}"
   for orig_file in "${tmp_folder}"/*.orig.json; do
     target_name="template.$(basename $orig_file|cut -d. -f1).json"
     target_file=${i18n_folder}/$target_name
     echo "Move ${orig_file} to ${target_file}"
     mv "${orig_file}" "${target_file}"
   done
   rm -rf "${tmp_folder}"

}

docker compose up -d --build
move_files "doctor" "/usr/share/nginx/html/assets/i18n/"
# not done as admin is not yet translated.
#move_files "admin" "/usr/share/nginx/html/assets/i18n/"
move_files "patient" "/usr/share/nginx/html/assets/i18n/"
move_files "backend" "/usr/src/app/config/locales/"
