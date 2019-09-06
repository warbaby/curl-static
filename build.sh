#!/bin/bash

cat <<EOF | docker run -i --rm -v "$PWD":/out -w /root alpine /bin/sh
apk add gcc make musl-dev openssl-dev
wget https://github.com/curl/curl/releases/download/curl-7_65_3/curl-7.65.3.tar.xz
tar xvfJ curl-7.65.3.tar.xz 
cd curl-*
./configure --disable-shared --with-ca-fallback
make curl_LDFLAGS=-all-static 
make install
cp /usr/local/bin/curl /out
strip /out/curl
chown $(id -u):$(id -g) /out/curl
EOF
