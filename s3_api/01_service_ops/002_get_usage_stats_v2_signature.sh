#!/bin/bash

s3AccessKey="LFFBEITQZ9KFQY4LF4EU"
s3SecretKey="5ICKqtY95pGwaBrXRrCbrz3byRCSQdsqxsRPGdPE"
ip="172.16.60.89"
port="7480"

date=`date +%Y%m%d`
dateFormatted=`date -u -R`

s3Bucket=""
method="GET"
contentType=""
contentMD5=""

amzRequests=""

if [ ${s3Bucket} ]
then
	relativePath="/${s3Bucket}"
else
	relativePath="/"
fi
stringToSign="${method}\n${contentMD5}\n${contentType}\n${dateFormatted}\n${amzRequests}${relativePath}"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3SecretKey} -binary | base64`

echo -e "Host: "${ip}:${port}
echo -e "Date: "${dateFormatted}
echo -e "Authorization: AWS "${s3AccessKey}:${signature}
