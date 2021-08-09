#!/bin/bash

while read -r line
do
	uid1=`echo $line | awk '{ print tolower($1)}'`
	uid2=`echo $line | awk '{ print tolower($2)}'`
	uid="$uid1.$uid2"
   	fname=`echo $line | awk '{ print $1}'`
	lname=`echo $line | awk '{ print $2}'`
	email=`echo $line | awk '{ print $3}'`
	mobile=`echo $line | awk '{ print $4}'`
	home=`echo $line | awk '{ print $5}'`
	emp=`echo $line | awk '{ print $6}'`
	address=`echo $line | awk '{for(i=7;i<=NF;i++) printf $i" "; print ""}'`
	passwd=`slappasswd -h {SSHA} -s $uid1`
	echo "dn: uid=$uid,ou=$emp,ou=staff,dc=ltacademy,dc=com" >> users.ldif
	echo "objectclass: inetOrgPerson" >> users.ldif
	echo "objectclass: top" >> users.ldif
	echo "cn: $fname" >> users.ldif
	echo "sn: $lname" >> users.ldif
	echo "mail: $email" >> users.ldif
	echo "mobile: $mobile" >> users.ldif
	echo "homePhone: $home" >> users.ldif
	echo "street: $address" >> users.ldif
	echo "uid: $uid" >> users.ldif
	echo "userPassword: $passwd" >> users.ldif
	echo "" >> users.ldif
done < data-users
