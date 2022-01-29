FROM golang:1.17-alpine3.15

WORKDIR /home/webhook

RUN mkdir /var/lib/webhook-data
VOLUME /var/lib/webhook-data

RUN wget https://github.com/adnanh/webhook/archive/master.tar.gz && \
    tar -xzvf master.tar.gz && rm master.tar.gz && cd webhook-master && go build

COPY hooks.json .
COPY write-webhook.sh . 

CMD /home/webhook/webhook-master/webhook -hooks hooks.json -verbose