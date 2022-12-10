#!/bin/bash

# Inisialisasi variabel untuk nama image dan versi
$__namedImage="item-app:v1"

# Perintah untuk membuat image dari Dockerfile
docker build -t $__namedImage --file Dockerfile .

# Menampilkan daftar image yang ada dengan kriteria tertentu
docker images --all | awk '{ print $1 " / "  $2 }' | grep "item-*

# Duplikasi image yang sebelumnya dibuat sesuai format penamaan registry
docker tag $__namedImage $__usernameDockerHub/$__namedImage

# Melakukan autentikasi akun ke registry
echo "$__passwordDockerHub" | docker login --username $__usernameDockerHub --password-stdin

# Mengunggah image ke namespace
docker push $__usernameDockerHub/$__namedImage

