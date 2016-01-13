#!/bin/sh
# original source: https://jira.zarafa.com/browse/ZUCS-28
# This script creates the needed fields in the Univention GUI to manage per user IMAP, Pop3 and Z-Push access
# These values can be used to override the config option disabled_features in server.cfg.
# To globally disable a feature add it to disabled_features (by default is "imap pop3"), to globally enable it simply remove it from there.
#
# TODO: add a dropdown or something to enable these features

eval "$(ucr shell)"

# Drop down for values. WIP
#univention-directory-manager settings/syntax create --ignore_exists \
#        --position "cn=zarafa,cn=custom attributes,cn=univention,$ldap_base" \
#        --set name=z4uEnabledFeatureSyntax \
#        --set description="Search syntax for Zarafa Enabled Features" \
#        --set filter="" \
#        --set ldapattribute="cn" \
#        --set ldapvalue="cn" \
#        --set viewonly=FALSE \
#        --set addEmptyValue=1
#
#        #--set syntax=z4uEnabledFeatureSyntax \

univention-directory-manager settings/extended_attribute create "$@" --ignore_exists \
	--position "cn=zarafa,cn=custom attributes,cn=univention,$ldap_base" \
	--set name="zarafaEnabledFeature" \
	--set module=users/user \
	--set tabName="Zarafa" \
	--set shortDescription="Enable specific features for User" \
	--set longDescription="Enable specific features for User" \
	--set translationShortDescription='"de_DE" "Aktiviere spezifische Features (imap/pop3/mobile) für Benutzer"' \
	--set translationLongDescription='"de_DE" "Aktiviere spezifische Features (imap/pop3/mobile) für Benutzer"' \
	--set objectClass=zarafa-user \
	--set syntax=string \
	--set mayChange=1 \
	--set ldapMapping=zarafaEnabledFeatures \
	--set multivalue=1 \
	--set tabPosition=99

univention-directory-manager settings/extended_attribute create "$@" --ignore_exists \
	--position "cn=zarafa,cn=custom attributes,cn=univention,$ldap_base" \
	--set name="zarafaDisabledFeature" \
	--set module=users/user \
	--set tabName="Zarafa" \
	--set shortDescription="Disable specific features for User" \
	--set longDescription="Disable specific features for User" \
	--set translationShortDescription='"de_DE" "Deaktiviere spezifische Features (imap/pop3/mobile) für Benutzer"' \
	--set translationLongDescription='"de_DE" "Deativiere spezifische Features (imap/pop3/mobile) für Benutzer"' \
	--set objectClass=zarafa-user \
	--set syntax=string \
	--set mayChange=1 \
	--set ldapMapping=zarafaDisabledFeatures \
	--set multivalue=1 \
	--set tabPosition=100