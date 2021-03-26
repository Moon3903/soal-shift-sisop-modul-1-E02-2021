#!/bin/bash
filepath="/home/ryan/Desktop/modul1/soal3/"
bash "$filepath/soal3a.sh"
foldername=$(date +"%d-%m-%Y")

mkdir "$filepath""$foldername"
mv "$filepath"Koleksi* "$filepath""$foldername/"
mv "$filepath"Foto.log "$filepath""$foldername/"



