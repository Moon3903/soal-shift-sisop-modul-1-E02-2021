# SoalShiftSISOP21_modul1_E02
## Anggota Kelompok E02
05111940000001 - Christoper Baptista

05111940000101 - Zulfiqar Fauzul Akbar

05111940000152 - Ryan Fernaldy

# Soal 1
## Penjelasan
a) Mengumpulkan informasi jenis log (ERROR/INFO), pesan log, dan username dari file syslog.log menggunakan regex.
b) menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
c) menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.
## Penyelesaian

### Bagian poin 1a)

### Bagian poin 1b)

### Bagian poin 1c)

### Bagian poin 1d)

### Bagian poin 1e)

# Soal 2
## Penjelasan
a) Mencari Row ID dengan profit percentage terbesar pada setiap transaksi (jika ada yang sama pilih Row ID terbesar)</br>
b) Mencari nama customer yang melakukan transaksi pada tahun 2017 di kota Albuquerque</br>
c) Mencari segment customer dengan jumlah transaksinya paling sedikit</br>
d) Mencari Region dengan total keuntungan (profit) paling sedikit</br>
e) Membuat script laporan dari poin a,b,c,d hasilnya disimpan ke 'hasil.txt' dengan format:</br>

```
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```
## Penyelesaian
- Menggunakan LC_ALL=C agar bisa mengambil angka desimal yang dipisahkan oleh '.' dengna tepat 
- Karena file Laporan-TokoShiSop.tsv memiliki header maka diberikan NR > 1 agar pembacaan dapat dimulai dari baris ke-2.
- Secara garis besar, untuk menyelesaikan soal ini menggunakan associative array. Associative array merupakan array yang indexnya dapat berupa string.

### Bagian poin 2a)
Pada bagian action:
```
cost_price=$18-$21;
profit_percentage=$21/cost_price*100;
if(profit_percentage >= maximum_profit_percentage){
	maximum_profit_percentage=profit_percentage;
	rowID=$1;
}
```
Melakukan pengecekan setiap baris dari awal hingga akhir. Jika suatu baris memiliki profit yang lebih besar atau sama dengan profit terbesar yang disimpan saat ini, maka nilai profit dan id transaksi (Order ID pada kolom 2) akan disimpan ke variabel maximum_profit_percentage dan id_transaksi.


Pada bagian END:
```
print "Transaksi terakhir dengan profit percentage terbesar yaitu " rowID " dengan persentase " maximum_profit_percentage "%.\n";
```
Mencetak variabel id_transaksi dan maximum_profit_percentage sesuai dengan format

### Bagian poin 2b)
Pada bagian action:
```
split($2,split_orderid,"-");
if($10 == "Albuquerque" && split_orderid[2] == 2017){
	arr_cust[$7]++;
}
```
Menggunakan associative array dengan nama customer (Customer name pada kolom 7) sebagai index dan jumlah muncul sebagai valuenya. Dengan mengggunakan associative array secara otomatis tidak akan menampilkan nama customer yang sama. Pada setiap baris akan dilakukan pengecekan nama kota (City pada kolom 10) dan Order ID (pada kolom 2).Tahun bisa diperoleh dari Order ID menggunakan bantuan fungsi split dengan separator '-' sehingga tahun dapat diakses pada index ke-2 pada array split_orderid. Jika baris tersebut memiliki kota Albuquerque dan tahun 2017 maka akan dimasukkan ke associative array dengan index sesuai dengan nama customer pada baris tersebut.


Pada bagian END:
```
print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:";
for(i in arr_cust){
	print i;
}
print "";
```
Mencetak index dari associative array dengan format yang diberikan

### Bagian poin 2c)
Pada bagian action:
```
ctr_segment[$8]++;
```
Menggunakan associative array dengan segment (pada kolom 8) sebagai index dan counter jumlah transaksi yang dilakukan sebagai value. Pada setiap baris akan melakukan increment terhadap value dari array sesuai dengan segmentnya. 


Pada bagian END:
```
min_transaction=99999999;
for(i in ctr_segment){
	if(ctr_segment[i] < min_transaction){
		min_transaction=ctr_segment[i];
		segment=i;
	}
}
print "Tipe segmen customer yang penjualannya paling sedikit adalah " segment " dengan " min_transaction " transaksi.\n";
```
Melakukan pengecekan untuk mencari segment serta jumlah transaksinya yang paling sedikit. Dengan menggunakan for loop jika jumlah transaksi dari suatu segment lebih kecil dari nilai yang disimpan saat ini maka index dan valuenya akan disimpan ke variabel segment dan min_transaction. Setelah selesai, variabel segment dan min_transaction akan dicetak dengan format yang diberikan

### Bagian poin 2d)
Pada bagian action:
```
region_profit[$13] += $21;
```
Menggunakan bantuan associative array region_profit dengan region (pada kolom 13) sebagai index dan akumulasi jumlah keuntungan yang dilakukan sebagai value. Pada setiap baris akan menambahkan profit (pada kolom 21) ke value yang tersimpan pada array sesuai dengan regionnya.


Pada bagian END:
```
min_profit=99999999;
for(i in region_profit){
	if(region_profit[i] < min_profit){
		min_profit=region_profit[i];
		region=i;
	}
}
print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " region " dengan total keuntungan " min_profit;
```
Melakukan pengecekan untuk mencari region serta total keuntungannya yang paling sedikit. Dengan menggunakan for loop jika total keuntungan dari suatu region lebih kecil dari nilai yang disimpan saat ini maka index dan valuenya akan disimpan ke variabel region dan min_profit. Setelah selesai, variabel region dan min_profit akan dicetak sesuai dengan format yang diberikan.

### Menyimpan output ke 'hasil.txt'
Melakukan redirection untuk mengirim output laporan ke 'hasil.txt' dengan menambahkan ``> hasil.txt`` pada bagian akhir

# Soal 3

## Penjelasan

a) Mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" dan simpan log-nya ke file Foto.log kemudian hapus yang kembar dan disimpan dengan nama "Koleksi_XX". XX menyatakan nomor (01,02,...) secara berurutan tanpa ada nomor yang hilang. </br>
b) Menjalankan script poin a) kemudian memindahkan gambar dan log ke folder dengan nama tanggal unduhnya "DD-MM-YYYY" secara otomatis pada jam 8 malam dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). </br>
c) Mengunduh 23 gambar kucing atau kelinci secara bergantian yang disimpan ke folder "Kucing_DD-MM-YYYY" atau "Kelinci_DD-MM-YYYY". Hari pertama bebas boleh kucing/kelinci, namun untuk hari berikutnya harus berbeda dengan hari sebelumnya. </br>
d) Memindahkan seluruh folder ke zip dengan password tanggal saat ini "MMDDYYYY". </br>
e) Setiap hari senin hingga jumat Melakukan zip pada jam 07.00 dan melakukan unzip pada jam 18.01. </br>

## Penyelesaian

### Soal 3a)

```
generate_name(){
	if [ $1 -lt 10 ]
	then
 		filename="$filepath""Koleksi_0$1"
	else
 		filename="$filepath""Koleksi_$1"
	fi
}

```

Fungsi generate_name() untuk men-generate namafile sesuai dengan angka yang diberikan pada saat pemanggilan

```
jumlah=23;
for((i=1; i<=jumlah; i++))
do
	generate_name "$i"
	wget -a "$filepath"Foto.log -O "$filename" https://loremflickr.com/320/240/kitten
	echo "$filename: Foto terdownload âœ“"
done

```

Mendowload gambar sebanyak 23 kali dengan for loop. pada wget terdapat -a untuk melakukan append pencatatan log, -O untuk me-rename gambar.

```
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
  			echo "$filename: Terdapat foto yang sama âœ—"
   			echo "$filename: Foto terhapus âœ“"
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
```

Melakukan pengecekan apakah ada gambar yang kembar. Gambar ke-i akan dibandingkan dengan gambar ke i+1 hingga jumlah. Pengecekan menggunakan `cmp -s file1 file2` yang akan memberikan exit status 0 juka kedua file sama. Exit status 0 dapat diambil dengan variabel `$?`. Jika kembar maka file yang terakhir dihapus dan file yang berada di belakang file tersebut namanya akan direname menjadi satu urutan lebih maju.

### Soal 3b)

Pada script `soal3b.sh`:</br>

```
CODE soal3b.sh
```

Menjalankan script `soal3a.sh`. `mkdir` untuk membuat folder baru. Setelah itu memindahkan gambar dengan `mv "$filepath"Koleksi* "$filepath""$foldername/"` serta log dengan
`mv "$filepath"Foto.log "$filepath""$foldername/"`

Pada script `cron3b.tab`:</br>

```
CODE cron3b.tab
```

Menjalankan script `soal3b.sh`.Kolom pertama menunjukan pada menit 0. Kolom kedua menujukkan pukul 20. Kolom ketiga menunjukkan tanggal 1 hingga tanggal 31 dengan step counter setiap 7 hari dan tanggal 2 hingga tanggal 31 dengan step counter 4 hari.

### Soal 3c)

Secara konsep mirip dengan penjalasan pada soal 3a). Fungsi generate_name() sama dengan yang ada soal 3a).

```
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
```

Cara mendownload mirip dengan soal 3a) hanya saja dibuat kedalam fungsi karena harus mendownload dari gambar yang berbeda sesuai dengan kondisi. Fungsi download() akan menerima parameter "Kucing" atau "Kelinci" saat dipanggil.

```
yesterday=$(date -d "yesterday" +"%d-%m-%Y")

# cek apakah direktori kucing kemarin sudah ada
test -d "$filepath""Kucing_""$yesterday"

if [ $? = 0 ]
then
	#download kelinci
	today=$(date +"%d-%m-%Y")
	foldername="Kelinci_""$today"
	filepath="$filepath""$foldername""/"
	mkdir "$filepath"
	download "Kelinci"
else
	#download kucing
	today=$(date +"%d-%m-%Y")
	foldername="Kucing_""$today"
	filepath="$filepath""$foldername""/"
	mkdir "$filepath"
	download "Kucing"
fi
```

Melakukan pengecekan apakah ada folder `Kucing_$yesterday` dengan `$yesterday` adalah tanggal kemarin yang dapat diperoleh `$(date -d "yesterday" +"%d-%m-%Y")`. Pengecekan dapat dilakukan dengan `test -d "$filepath""Kucing_""$yesterday"` yang akan memberikan exit status 0 jika folder ditemukan. Exit status dapat diambil dengan variabel `$?`. Jika sudah ada, maka buat folder baru dengan `mkdir` kemudian panggil fungsi `download` dengan parameter `"Kelinci"`. Demikian pula sebaliknya.

### Soal 3d)

```
CODE!!!!
```

Sebelum melakukan zip, harus dipastikan berada di posisi direktori yang sesuai menggunakan `cd`. Password sesuai dengan perintah dapat diperoleh dari `$(date +"%m%d%Y")`. Kemudian memindahkan seluruh folder hasil unduhan ke dalam zip (menggunakan `-rm`). Untuk mengambil file yang berupa directory saja menggunakan path `./*/`.

### Soal 3e)

```
CODE!!!!
```

- Pada baris pertama untuk melakukan zip dengan menjalankan script `soal3d.sh`. Kolom pertama menyatakan menit 0, kolom kedua menyatakan pukul 7, kolom kelima menunjukkan hari Senin hingga hari Jumat.
- Pada baris kedua untuk melakukan unzip dengan password (menggunakan `-P`) berupa tanggal hari ini sesuai dengan format yang dapat diperoleh dari `` `date +"\%m\%d\%Y"` `` kemudian `-d` untuk mengatur hasil extract. Setelah itu menghapus file zip dengan `rm`. Zip dilakukan dari pukul 7 hingga pukul 18 artinya unzip dapat dilakukan pada pukul 18.01. Kolom pertama menyatakan menit 1, kolom kedua menyatakan pukul 18, kolom kelima menunjukkan hari Senin hingga hari Jumat.
