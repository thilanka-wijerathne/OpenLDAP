#!/bin/bash

while read -r line
do
	id=`echo "$line" | awk 'BEGIN {FS="\t"}; { print $2 }'`
   	name=`echo "$line" | awk 'BEGIN {FS="\t"}; {print $1}'`
	publisher=`echo "$line" | awk 'BEGIN {FS="\t"}; { print $3}'`
	echo "$id-$name-$publisher"
	echo "dn: documentIdentifier=$id,ou=books,dc=ltacademy,dc=com" >> books.ldif
	echo "objectclass: document" >> books.ldif
	echo "objectclass: top" >> books.ldif
	echo "cn: $name" >> books.ldif
	echo "documentIdentifier: $id" >> books.ldif
	echo "documentPublisher: $publisher" >> books.ldif
	echo "" >> books.ldif
done < data-books
