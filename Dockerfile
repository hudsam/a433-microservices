FROM node:14
RUN mkdir /app
WORKDIR /app
COPY . /app
ENV NODE_ENV=production DB_HOST=item-db
RUN npm install --production --unsafe-perm && npm run build
EXPOSE 8080
CMD ["npm", "start"]

