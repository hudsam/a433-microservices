# Penggunaan namespace: node.js versi:14-sekian untuk baseline program
FROM node:14

# Menjalankan perintah pembuatan folder: /app
RUN mkdir /app

# Melakukan perpindahan working directory ke dalam folder: /app
WORKDIR /app

# Menyalin semua dokumen yang ada pada current directory ke dalam folder: /app
COPY . /app

# Menginisialisasi environment variable
ENV NODE_ENV=production DB_HOST=item-db

# Menjalankan perintah instalasi assets node.js
RUN npm install --production --unsafe-perm && npm run build

# Menentukan port mapping untuk program gunakan, yaitu 8080
EXPOSE 8080

# Perintah untuk menjalankan program sesuai pada script: package.json
CMD ["npm", "start"]

