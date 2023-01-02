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
     pip install -r requirements.txt          && \
     apk del --purge .build-deps

CMD envsubst < docker-apiconfig.py > userapiconfig.py && \
    python server.py
    

