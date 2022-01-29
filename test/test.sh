#!/bin/sh

# uses generated key for ease of use
PASSWORD=$(echo -n $PASS | openssl enc -e -aes-256-cbc -a -pass file:/key/secret.key)
URL="http://webhook:9000/hooks/write"

# remove existing test files
rm /var/lib/webhook-data/foo.txt
rm /var/lib/webhook-data/bar.txt

# test initial write
curl -s --location --request POST "$URL" \
--header 'File-Name: foo.txt' \
--header 'Secret: '$PASSWORD'' \
--header 'Content-Type: application/json' \
--data-raw '{ "text": "number 1 and number 2 and number 3" }'

EXPECTED="number 1 and number 2 and number 3"
RESULT="$(cat /var/lib/webhook-data/foo.txt)"
if [ "$EXPECTED" != "$RESULT" ]
then 
    echo "First test case failed"
    exit 1
fi

# test append
curl -s --location --request POST "$URL" \
--header 'File-Name: foo.txt' \
--header 'Secret: '$PASSWORD'' \
--header 'Content-Type: application/json' \
--data-raw '{ "text": "number 2 and number 3 and number 4" }'

EXPECTED="number 1 and number 2 and number 3 number 2 and number 3 and number 4"
RESULT="$(echo -e $(cat /var/lib/webhook-data/foo.txt))"
if [ "$EXPECTED" != "$RESULT" ]
then 
    echo "Second test case failed"
    exit 1
fi

# test another filename
curl -s --location --request POST "$URL" \
--header 'File-Name: bar.txt' \
--header 'Secret: '$PASSWORD'' \
--header 'Content-Type: application/json' \
--data-raw '{ "text": "number 4 and number 5 and number 6" }'

EXPECTED="number 4 and number 5 and number 6"
RESULT="$(cat /var/lib/webhook-data/bar.txt)"
if [ "$EXPECTED" != "$RESULT" ]
then 
    echo "Third test case failed"
    exit 1
fi

# TEST AUTHENTICATION FAILS to execute
PASSWORD=$(echo -n "failure" | openssl enc -e -aes-256-cbc -a -pass file:/key/secret.key)
curl -s --location --request POST "$URL" \
--header 'File-Name: bar.txt' \
--header 'Secret: '$PASSWORD'' \
--header 'Content-Type: application/json' \
--data-raw '{ "text": "number 4 and number 5 and number 6" }'

EXPECTED="number 4 and number 5 and number 6"
RESULT="$(cat /var/lib/webhook-data/bar.txt)"
if [ "$EXPECTED" != "$RESULT" ]
then 
    echo "Last test case failed"
    exit 1
fi
