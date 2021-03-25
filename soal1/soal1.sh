#!/bin/bash

#(a) 
echo "semua line"
grep -o 'y:.*' syslog.log | cut -f2- -d\ 
hadeh=($(grep -o 'y:.*' syslog.log| cut -f2- -d\ ))

#(b) 
echo "--- pesan dan jumlah ---"
grep -o 'ERROR.*' syslog.log | cut -f2- -d\ | cut -d"(" -f 1 | sort | uniq -c | sort -nr

#(c)
echo "ERROR"
grep -o 'ERROR.*' syslog.log | cut -f2- -d"(" |cut -d")" -f 1| sort | uniq -c

echo "INFO"
grep -o 'INFO.*' syslog.log | cut -f2- -d"(" |cut -d")" -f 1| sort | uniq -c

#(d)
hadeh=($(grep -o 'ERROR.*' syslog.log | cut -f2- -d\ | cut -d"(" -f 1 | sort | uniq -c | sort -nr))
cek=0
space=0
echo "Error,Count" > error_message.csv
for i in "${!hadeh[@]}"
do
	if [[ "${hadeh[i]}" =~ ^[0-9] ]]
	then
		if [ $cek == 1 ]
		then
			space=0
			echo ",$sebelum" >> error_message.csv
		fi
		cek=1
		sebelum=${hadeh[i]}
	else
		if [ $space -gt 0 ]
		then
			echo -n " " >> error_message.csv
		fi
		echo -n ${hadeh[i]} >> error_message.csv
		space=1 
	fi
done
echo ",$sebelum" >> error_message.csv

#(e)
ERROR=($(grep -o 'ERROR.*' syslog.log | cut -f2- -d"(" |cut -d")" -f 1| sort | uniq -c))
INFO=($(grep -o 'INFO.*' syslog.log | cut -f2- -d"(" |cut -d")" -f 1| sort | uniq -c))

e=0
i=0

echo "Username,INFO,ERROR" > user_statistic.csv

while [ $i -lt ${#INFO[@]} ]
do
	while [[ "${INFO[i+1]}" > "${ERROR[e+1]}" ]]
	do
		echo "${ERROR[e+1]},0,${ERROR[e]}" >> user_statistic.csv
		e=$(($e+2))
	done
	if [[ "${INFO[i+1]}" == "${ERROR[e+1]}" ]]
	then
		echo "${INFO[i+1]},${INFO[i]},${ERROR[e]}" >> user_statistic.csv
		e=$(($e+2))
	elif [[ "${INFO[i+1]}" < "${ERROR[e+1]}" ]]
	then
		echo "${INFO[i+1]},${INFO[i]},0" >> user_statistic.csv
	fi
	i=$(($i + 2))
done

while [ $e -lt ${#ERROR[@]} ]
do
	echo "${ERROR[e+1]},0,${ERROR[e]}" >> user_statistic.csv
	e=$(($e+2))
done