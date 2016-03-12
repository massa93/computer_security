#!/bin/bash

rm -f cipher
rm -f secret.zip
rm -f key

echo "It's a secret to everybody" > secret.txt
zip secret secret.txt
rm -f secret.txt

head -c 4 /dev/urandom > key
key=$(xxd -b key | cut -d: -f 2 | sed 's/  .*//; s/ //g' | tr -d '\n')
echo 'Key: '$key

head -c 4 secret.zip > magic
magic=$(xxd -b magic | cut -d: -f 2 | sed 's/  .*//; s/ //g' | tr -d '\n')

plaintext=$(xxd -b secret.zip | cut -d: -f 2 | sed 's/  .*//; s/ //g' | tr -d '\n')

#from http://zurlinux.com/?p=712
cyphertext=""
j=0
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

#echo $ciphertext

#from http://stackoverflow.com/questions/7290943/write-a-string-of-1s-and-0s-to-a-binary-file
OFILE="cipher"
# A goofy wrapper to convert a sequence of 8 1s and 0s into a 8-bit number, expressed in hex
function bstr_to_byte()
{
    echo "obase=16;ibase=2;$1" | bc
}


# Build input string from stdin
#   This can be done using pipes ( echo "1010101..." | ./binstr.sh
#   Or "interactively", so long as you enter q on it's own line when you are done entering your
#       binary string.
ISTR=$(echo $ciphertext)

# Byte-by-byte conversion
while [[ $(expr length ${ISTR}) -ge 8 ]] ; do
    # Copy the first 8 characters
    BSTR=${ISTR:0:8}
    # Drop them from the input string
    ISTR=${ISTR:8}
    # Convert the byte-string into a byte
    BYTE=$(bstr_to_byte $BSTR)

    # Debug print
    ##echo "$BSTR => [ ${BYTE} ]"

    # Write character to file
    echo -en "\x${BYTE}" >> ${OFILE}

    # Check for empty ISTR, which will cause error on iteration
    if [[ -z ${ISTR} ]] ; then
        ##echo "String parsed evenly"
        break
    fi
done

#echo $ciphertext
#echo "$ciphertext" > cipher
#echo "$ciphertext" | xxd -r -b > cipher

#####################################################################################
#DECRYPT
head -c 4 cipher > cmagic
cmagic=$(xxd -b cmagic | cut -d: -f 2 | sed 's/  .*//; s/ //g' | tr -d '\n')

brute=""
for ((i=0; i < ${#magic}; i++ ))
do
	if [[ ${magic:$i:1} = ${cmagic:$i:1} ]]
	then
		brute="${brute}0"
	else
		brute="${brute}1"
	fi
done

if [[ $key = $brute ]]
then
	echo 'Key found: '$brute
else
	echo 'Key NOT found: '$brute
fi



