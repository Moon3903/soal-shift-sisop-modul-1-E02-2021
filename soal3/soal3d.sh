#!/bin/bash

filepath="/home/ryan/Desktop/modul1/soal3/"

cd "$filepath"

password=$(date +"%d%m%Y")
echo $password
zip --password "$password" -rm Koleksi ./*/

