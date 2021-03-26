#!/bin/bash

filepath="/home/ryan/Desktop/modul1/soal3/"

cd "$filepath"

password=$(date +"%d%m%Y")
zip --password "$password" -rm Koleksi ./*/

