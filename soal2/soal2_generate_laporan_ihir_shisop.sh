#!/bin/bash

LC_ALL=C awk 'BEGIN{FS="\t"; maximum_profit_percentage=-99999999;} 
NR > 1 {
		cost_price=$18-$21;
		profit_percentage=$21/cost_price*100;
		if(profit_percentage >= maximum_profit_percentage){
			maximum_profit_percentage=profit_percentage;
			rowID=$1;
		}

		split($2,split_orderid,"-");
		if($10 == "Albuquerque" && split_orderid[2] == 2017){
			arr_cust[$7]++;
		}

		ctr_segment[$8]++;
		
		region_profit[$13] += $21;
	}
END{
	print "Transaksi terakhir dengan profit percentage terbesar yaitu " rowID " dengan persentase " maximum_profit_percentage "%.\n";
	
	print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:";
	for(i in arr_cust){
		print i;
	}
	print "";
	
	min_transaction=99999999;
	for(i in ctr_segment){
		if(ctr_segment[i] < min_transaction){
			min_transaction=ctr_segment[i];
			segment=i;
		}
	}
	print "Tipe segmen customer yang penjualannya paling sedikit adalah " segment " dengan " min_transaction " transaksi.\n";

	
	min_profit=99999999;
	for(i in region_profit){
		if(region_profit[i] < min_profit){
			min_profit=region_profit[i];
			region=i;
		}
	}
	print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " region " dengan total keuntungan " min_profit;
}' Laporan-TokoShiSop.tsv > hasil.txt
