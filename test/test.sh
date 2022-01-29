#!/bin/sh

# uses generated key for ease of use
PASSWORD=$(openssl aes-256-cbc -a -in secret.txt -pass file:/key/secret.key)


curl --location --request POST 'http://webhook:9000/hooks/write' \
--header 'File-Name: test.txt' \
--header 'Secret: '$PASSWORD'' \
--header 'Content-Type: application/json' \
--data-raw '{ "text": "number 66 and number 2\n and number 3" }'