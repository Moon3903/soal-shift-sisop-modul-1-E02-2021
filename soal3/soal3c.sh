#!/bin/bash

filepath="/home/ryan/Desktop/modul1/soal3/"

generate_name(){
	if [ $1 -lt 10 ]
	then
		filename="$filepath""Koleksi_0$1"
	else
		filename="$filepath""Koleksi_$1"
	fi
}

download(){
	jumlah=23;

	for((i=1; i<=jumlah; i++))
	do
		generate_name "$i"
		if [ $1 == "Kucing" ] 
		then
			wget -a "$filepath"Foto.log -O "$filename" https://loremflickr.com/320/240/kitten
		elif [ $1 == "Kelinci" ]
		then
			wget -a "$filepath"Foto.log -O "$filename" https://loremflickr.com/320/240/bunny
		fi
	done


	for((i=1; i<=jumlah; i++))
	do
		generate_name "$i"
		file1=$filename;
		
		for((j=i+1; j<=jumlah; j++))
		do
			generate_name "$j"
			file2=$filename;
			
			cmp -s $file1 $file2
			if [ $? == 0 ]
			then
				rm $file2
				for((k=j+1; k<=jumlah; k++))
				do
					generate_name "$k"
					file3=$filename;
					generate_name "$(($k-1))"
					newname=$filename;
					mv "$file3" "$newname";
				done
				jumlah=$(($jumlah-1))
				j=$(($j-1))
			fi
		done
	done
}


yesterday=$(date -d "yesterday" +"%d-%m-%Y")

# cek apakah direktori kucing kemarin sudah ada
test -d "$filepath""Kucing_""$yesterday"

if [ $? = 0 ]
then
	#download kelinci
	today=$(date +"%d-%m-%Y")
	foldername="Kelinci_""$today"
	mkdir "$foldername"
	filepath="$filepath""$foldername""/"
	download "Kelinci"
else
	#download kucing
	today=$(date +"%d-%m-%Y")
	foldername="Kucing_""$today"
	mkdir "$foldername"
	filepath="$filepath""$foldername""/"
	download "Kucing"
fi


