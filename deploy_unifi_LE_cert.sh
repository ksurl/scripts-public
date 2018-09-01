#!/bin/bash

# ASSUMPTIONS:
# - passwordless ssh key
# - ssh config file specifies username and ssh key for $unifihost
# - runs as user (using ~ for default acme.sh install location)

# change this: 
domain="DOMAIN"
unifihost="HOSTNAME"

# keystore file
keystore=/var/lib/unifi/keystore

# cert files
key=~/.acme.sh/$domain/$domain.key
cert=~/.acme.sh/$domain/$domain.cer
chain=~/.acme.sh/$domain/ca.cer

# unifi config
alias=unifi
password=aircontrolenterprise

# temp files
p12=$(mktemp)
ca=$(mktemp)

# create trustid x3 temp ca file
cat > "$ca" <<'_EOF'
-----BEGIN CERTIFICATE-----
MIIDSjCCAjKgAwIBAgIQRK+wgNajJ7qJMDmGLvhAazANBgkqhkiG9w0BAQUFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTAwMDkzMDIxMTIxOVoXDTIxMDkzMDE0MDExNVow
PzEkMCIGA1UEChMbRGlnaXRhbCBTaWduYXR1cmUgVHJ1c3QgQ28uMRcwFQYDVQQD
Ew5EU1QgUm9vdCBDQSBYMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AN+v6ZdQCINXtMxiZfaQguzH0yxrMMpb7NnDfcdAwRgUi+DoM3ZJKuM/IUmTrE4O
rz5Iy2Xu/NMhD2XSKtkyj4zl93ewEnu1lcCJo6m67XMuegwGMoOifooUMM0RoOEq
OLl5CjH9UL2AZd+3UWODyOKIYepLYYHsUmu5ouJLGiifSKOeDNoJjj4XLh7dIN9b
xiqKqy69cK3FCxolkHRyxXtqqzTWMIn/5WgTe1QLyNau7Fqckh49ZLOMxt+/yUFw
7BZy1SbsOFU5Q9D8/RhcQPGX69Wam40dutolucbY38EVAjqr2m7xPi71XAicPNaD
aeQQmxkqtilX4+U9m5/wAl0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNV
HQ8BAf8EBAMCAQYwHQYDVR0OBBYEFMSnsaR7LHH62+FLkHX/xBVghYkQMA0GCSqG
SIb3DQEBBQUAA4IBAQCjGiybFwBcqR7uKGY3Or+Dxz9LwwmglSBd49lZRNI+DT69
ikugdB/OEIKcdBodfpga3csTS7MgROSR6cz8faXbauX+5v3gTt23ADq1cEmv8uXr
AvHRAosZy5Q6XkjEGB5YGV8eAlrwDPGxrancWYaLbumR9YbK+rlmM6pZW87ipxZz
R8srzJmwN0jP41ZL9c8PDHIyh8bwRLtTcm1D9SZImlJnt1ir/md2cXjbDaJWFBM5
JDGFoqgCWjBH4d1QB7wCCZAA62RjYJsWvIjJEubSfZGL+T0yjWW06XyxV3bqxbYo
Ob8VZRzI9neWagqNdwvYkQsEjgfbKbYK7p2CNTUQ
-----END CERTIFICATE-----
_EOF

# stop unifi controller
ssh $unifihost systemctl stop unifi

# backup keystore
ssh $unifihost cp $keystore $keystore.bak

# export cert files to PKCS12 file
openssl pkcs12 -export -in $cert -inkey $key -CAfile $chain -out $p12 -passout pass:$password -caname root -name $alias
	
# delete previous cert from keystore
ssh $unifihost keytool -delete -alias $alias -keystore $keystore -deststorepass $password
	
# import PKCS12 file into keystore
ssh $unifihost keytool -importkeystore -srckeystore $p12 -srcstoretype PKCS12 -srcstorepass $password -destkeystore $keystore -deststorepass $password -destkeypass $password -alias $alias -trustcacerts
	
# import ca into keystore
ssh $unifihost java -jar /usr/lib/unifi/lib/ace.jar import_cert $cert $chain $ca

# delete temp files
rm -f $p12
rm -f $ca

# Restart the UniFi Controller to pick up the updated keystore
ssh $unifihost systemctl start unifi
