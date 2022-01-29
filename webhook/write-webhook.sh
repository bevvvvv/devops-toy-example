#!/bin/sh

set -e
PASSWORD=$(echo $3| openssl base64 -d | openssl enc -d -aes-256-cbc -pass file:/secret.key)

if [ $PASSWORD != $PASS ]
then
    echo "Permission Denied."
    exit 126
fi

echo -e $1 >> $2