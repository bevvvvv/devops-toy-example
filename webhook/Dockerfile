FROM golang:1.17-alpine3.15

# using symmetric key for pass auth
VOLUME /home/webhook/key
RUN mkdir -p /home/webhook/key && chmod 755 -R /home/webhook/key && \
    apk update && apk add openssl && \
    openssl rand -out /secret.key 32

# get webhook Go app
RUN cd /home/webhook/ && wget https://github.com/adnanh/webhook/archive/master.tar.gz && \
    tar -xzvf master.tar.gz && rm master.tar.gz && cd webhook-master && go build

# copy hook config and script
COPY hooks.json /home/webhook
COPY write-webhook.sh /home/webhook

# persistent directory for writing
RUN mkdir /var/lib/webhook-data
VOLUME /var/lib/webhook-data

WORKDIR /home/webhook

CMD cp /secret.key ./key && webhook-master/webhook -hooks hooks.json -verbose