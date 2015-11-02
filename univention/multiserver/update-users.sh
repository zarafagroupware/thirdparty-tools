#!/bin/sh
# Update existing (single-server) users inside of the Univention LDAP with their new home server.
# Please put name of of the desired Zarafa host into the variable "newhost"

eval "$(ucr shell)"
newhost=master

for i in $( zarafa-admin -l | tail -n +4 | grep -v SYSTEM | awk {'print $1'} ); do
	univention-directory-manager users/user modify --dn uid=$i,cn=users,$ldap_base \
	--set z4uUserServer="$newhost"
done
