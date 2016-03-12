#!/bin/bash

rm -f cipher
rm -f secret.zip
rm -f key

echo "It's a secret to everybody" > secret.txt
zip secret secret.txt
rm secret.txt

head -c 4 /dev/urandom > key
key=$(xxd -b key | cut -d: -f 2 | sed 's/  .*//; s/ //g' | tr -d '\n')

plaintext=$(xxd -b secret.zip | cut -d: -f 2 | sed 's/  .*//; s/ //g' | tr -d '\n')

#echo $key
#echo
#echo $plaintext
#from http://zurlinux.com/?p=712
cyphertext=""
j=0

#echo ${plaintext}
for ((i=0; i < ${#plaintext}; i++ ))
do
	ord=${plaintext:$i:1}
	k=${key:$j:1}
	tmp=$((ord ^ k))
	ciphertext="${ciphertext}${tmp}"
	if [ "$j" = "$((${#key} - 1))" ];
	then
		j=0
	else
		j=$(($j+1))
	fi
		
   #ord=$(printf "%d" "'${plaintext:$i:1}")
   #tmp=$(printf \\$(printf '%03o' $((ord ^ )) ))
   #ciphertext="${ciphertext}${tmp}"
done
 
echo "$ciphertext" | xxd -r -p > cipher
