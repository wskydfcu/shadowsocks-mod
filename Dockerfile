FROM python:3.9.2-alpine

COPY . /app
WORKDIR /app

RUN apk add --no-cache \
        gcc \
        libsodium-dev \
        libffi-dev \
        openssl-dev && \
    apk add --no-cache --virtual .build \
        libc-dev \
        rust \
        cargo && \
     cp  /usr/bin/envsubst  /usr/local/bin/   && \
     pip install --upgrade pip                && \
     pip install -r requirements.txt          && \
     rm -rf ~/.cache && touch /etc/hosts.deny && \
     apk del --purge .build-deps

CMD envsubst < apiconfig.py > userapiconfig.py && \
    envsubst < config.json > user-config.json  && \
    echo -e "${DNS_1}\n${DNS_2}\n" > dns.conf  && \
    python server.py
