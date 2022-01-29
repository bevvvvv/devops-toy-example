FROM alpine:3.15

RUN apk update && apk add curl

CMD curl --location --request POST 'webhook:9000/hooks/write' \
--header 'File-Name: automated.txt' \
--header 'Content-Type: text/plain' \
--data-raw '{ "text": "number 66 and number 2\n and number 3" }'