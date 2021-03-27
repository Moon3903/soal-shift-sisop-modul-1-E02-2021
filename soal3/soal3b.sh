#!/bin/bash

filepath="/home/christopher/Documents/SoalShift1/"
bash "$filepath""soal3a.sh"
foldername=$(date +"%d-%m-%Y")

mkdir "$filepath""$foldername"
mv "$filepath"Koleksi* "$filepath""$foldername/"
mv "$filepath"Foto.log "$filepath""$foldername/"
