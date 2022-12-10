#!/bin/bash

##### Program Pendukung #####

# Inisialisasi variabel untuk nama image dan versi
$__namedImage="item-app:v1"

##### Program Utama #####

echo -e "[INFO] Mulai...\n"
# Pemberian jeda 3 detik
sleep 3

# Perintah untuk membuat image dari Dockerfile
docker build -t $__namedImage --file Dockerfile .
sleep 3

# Menampilkan daftar image yang ada dengan kriteria tertentu
docker images --all | awk '{ print $1 " / "  $2 }' | grep "item-*
sleep 3

# Duplikasi image yang sebelumnya dibuat sesuai format penamaan registry
docker tag $__namedImage $__usernameDockerHub/$__namedImage
sleep 3

# Melakukan autentikasi akun ke registry
echo "$__passwordDockerHub" | docker login --username $__usernameDockerHub --password-stdin
sleep 3

# Mengunggah image ke namespace
docker push $__usernameDockerHub/$__namedImage
sleep 3

echo "[INFO] Selesai..."

##### Akhir Program #####

