#!/bin/bash
#4294967296
for ((i=0; i<4294967296; i++ ))
do
	#echo -n 'Try $i: '
	try=$(./test $i)
	#echo $try
	if [ "${#try}" -gt "1" ]
	then
		echo 'Test '$i': '$try
	fi 
done
	
