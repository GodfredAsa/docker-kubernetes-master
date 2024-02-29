FROM node:12

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

EXPOSE 80

CMD ["node", "server.js"]

# ENSURE YOU ARE IN THE SAME DIRECTORY AS THE Dockerfile
# docker build .
# docker run -p 3000:80 imageID