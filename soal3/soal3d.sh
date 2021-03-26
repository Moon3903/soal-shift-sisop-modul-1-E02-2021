#!/bin/bash

filepath="/home/ryan/Desktop/modul1/soal3/"

cd "$filepath"

password=$(date +"%m%d%Y")
zip --password "$password" -rm Koleksi ./*/

