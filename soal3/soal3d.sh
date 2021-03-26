#!/bin/bash

filepath="/home/christopher/Documents/SoalShift1/"

cd "$filepath"

password=$(date +"%m%d%Y")
zip --password "$password" -rm Koleksi ./*/

