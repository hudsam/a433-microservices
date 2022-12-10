#!/bin/bash

##### Program Pendukung #####

# Inisialisasi variabel untuk nama image dan versi
$__namedImage="item-app:v1"

# Function untuk membuat image
function createdImage() {
	echo "[INFO] Membuat image..."
	# Melakukan inisialisasi proses build image dengan nama sesuai variabel sebelumnya sesuai instruksi Dockerfile
	__createdImage="docker build -t $__namedImage --file Dockerfile ."
	echo "[RUN] $__createdImage"
	$__createdImage
	echo -e ""
}

##### Program Utama #####

echo -e "[INFO] Mulai...\n"
# Pemberian jeda 3 detik
sleep 3

echo "[INFO] Menentukan Dockerfile..."
# Mencari file dengan nama: Dockerfile
if [[ -f "Dockerfile" ]]
then
	echo "[INFO] Ditemukan..."
	echo -e ""
	# Penggunaan function: createdImage
	createdImage
else
	echo "[WARN] Tidak ditemukan..."
	echo -e ""
	echo "[INFO] Ubah nama file dengan: Dockerfile"
	echo "[INFO] Program dihentikan."
	echo -e ""
	# Keluar dari program karena file: Dockerfile tidak ditemukan
	exit
fi
sleep 3

createdImage
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

