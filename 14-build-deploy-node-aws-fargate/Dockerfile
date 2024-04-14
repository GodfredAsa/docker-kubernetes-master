# FROM node:14-alpine

# WORKDIR /app

# COPY package.json .

# RUN npm install

# COPY . .

# EXPOSE 3000

# CMD [ "node", "index.js" ] 

FROM node:12
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN npm install
COPY . .
# Best for production scenario 
RUN npm install -g pm2  
EXPOSE 3000

CMD [ "pm2-runtime", "index.js" ]
