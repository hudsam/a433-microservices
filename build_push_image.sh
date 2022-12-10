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

# Function untuk menampilkan daftar image(s)
function listedImages() {
	echo "[INFO] Daftar image(s) dengan kategori: item-*..."
	# Melakukan inisialisasi dan mengambil daftar image(s) dengan filter string: item-*
	__listedImage="docker images --all | awk '{ print \$1 \" / \"  \$2 }' | grep \"item-*\""
	echo -e "[RUN] $__listedImage\n\n[INFO] Hasil..."
	docker images --all | awk '{ print $1 " / "  $2 }' | grep "item-*"
	echo -e ""
}

# Function untuk membuat namespace, image, dan versi
function setImage() {
	echo "[INFO] Menentukan nama image..."
	echo "[DATA] Menentukan namespace hub.docker.com: $__usernameDockerHub"
	# Melakukan inisialisasi dan duplikasi image sesuai format penamaan Docker Registry
	__changedImage="docker tag $__namedImage $__usernameDockerHub/$__namedImage"
	echo "[RUN] $__changedImage"
	$__changedImage
	echo -e ""
}

# Function untuk autentikasi akun Docker Registry (hub.docker.com)
function resetAutentikasi() {
	echo "[INFO] Menghapus session yang ada..."
	# Melakukan inisialisasi dan pembersihan session Docker Engine
	__resetSession="docker logout"
	echo "[RUN] $__resetSession"
	$__resetSession
	#setPause 2
	sleep 3

	echo "[INFO] Autentikasi ulang hub.docker.com ..."
	echo "[DATA] Menentukan username hub.docker.com: $__usernameDockerHub"
	echo "[DATA] Menentukan password hub.docker.com: $__passwordDockerHub"
	# Melakukan inisialisasi dan autentikasi ke Docker Registry
	__relogAutentikasi="docker login --username $__usernameDockerHub --password-stdin"
	echo "[RUN] $__passwordDockerHub | $__relogAutentikasi"
	echo "$__passwordDockerHub" | $__relogAutentikasi
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

# Penggunaan function: listedImages
listedImages
sleep 3

# Penggunaan function: setImage
setImage
sleep 3

# Penggunaan function: resetAutentikasi
resetAutentikasi
sleep 3

# Mengunggah image ke namespace
docker push $__usernameDockerHub/$__namedImage
sleep 3

echo "[INFO] Selesai..."

##### Akhir Program #####

