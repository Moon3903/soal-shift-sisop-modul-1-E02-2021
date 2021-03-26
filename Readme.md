# SoalShiftSISOP21_modul1_E02
## Anggota Kelompok E02
05111940000001-Christoper Baptista

05111940000101-Zulfiqar Fauzul Akbar

05111940000152-Ryan Fernaldy

# Soal 1

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
a) Menulis script yang mengunduh 23 foto acak dari "https://loremflickr.com/320/240/kitten" lalu menyimpan lognya ke dalam file "Foto.log". Jika terunduh foto yang sama (telah terunduh sebelumnya), maka foto tersebut akan dihapus. Kemudian gambar disimpan dengan nama "Koleksi_XX" dengan XX adalah nomor antrian unduhan secara berurutan</br>
b) Menulis script untuk menjalankan script 3a) secara otomatis sehari sekali setiap jam 8 malam mulai tanggal 1 tujuh hari sekali dan tanggal 2 empat hari sekali. Lalu memindahkan foto dan log ke dalam folder dengan nama tanggal unduhnya dengan format "dd-mm-yyyy"</br>
c) Menulis script yang mengunduh 23 foto anak kucing dan 23 foto kelinci secara bergantian setiap hari. Kemudian membuat folder terpisah untuk gambar kucing dengan nama folder "Kucing_" dan folder untuk gambar kelinci dengan nama "Kelinci_"</br>
d) Menulis script yang melakukan zip untuk seluruh folder gambar yang telah diunduh dengan nama "Koleksi.zip" serta diberi password yaitu tanggal saat ini dengan format "MMDDYYYY"</br>
e) Menulis script yang melakukan unzip dari file zip 3d) dan menghapus file zip aslinya pada hari senin sampai jumat dari jam 7 pagi hingga 6 sore</br>

## Penyelesaian

### Bagian poin 3a)

### Bagian poin 3b)

### Bagian poin 3c)

### Bagian poin 3d)

### Bagian poin 3e)
