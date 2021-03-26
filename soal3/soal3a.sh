#!/bin/bash

filepath="/home/christopher/Documents/SoalShift1/"
generate_name(){
	if [ $1 -lt 10 ]
	then
 		filename="$filepath""Koleksi_0$1"
	else
 		filename="$filepath""Koleksi_$1"
	fi
}

jumlah=23;
for((i=1; i<=jumlah; i++))
do
	generate_name "$i"
	wget -a "$filepath"Foto.log -O "$filename" https://loremflickr.com/320/240/kitten
	echo "$filename: Foto terdownload ✓"
done


for ((i=1; i<=jumlah; i++))
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
  			echo "$filename: Terdapat foto yang sama ✗"
   			echo "$filename: Foto terhapus ✓"
   			rm $file2
   			for ((k=j+1; k<=jumlah; k++))
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
