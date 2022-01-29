FROM alpine:3.15

RUN apk update && apk add curl openssl

RUN echo supersecretpassword > secret.txt
COPY test.sh .

CMD sh test.sh