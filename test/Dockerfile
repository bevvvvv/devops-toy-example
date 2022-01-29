FROM alpine:3.15

RUN apk update && apk add curl openssl

COPY test.sh .

CMD sh test.sh