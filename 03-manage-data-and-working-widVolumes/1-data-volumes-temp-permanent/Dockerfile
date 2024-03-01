FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# ALWAYS PLACE YOUR ENVs AND ARGs IN HERE AT THIS EXACT POSITION TO AVOID IMAGE REBUILD
ARG DEFAULT_PORT=80
ENV PORT $DEFAULT_PORT

EXPOSE $PORT

# ANONYMOUS VOLUME WHEN YOU USE THIS APPROACH THEN DONT INCLUDE IT WHEN RUNNING THE CONTAINER 
VOLUME [ "/tmp" ]
# pathToCodeBase: /Users/macintosh/Documents/WORKING FILES /Learnings/docker-kubernetes-master/03-manage-data-and-working-widVolumes/1-data-volumes-temp-permanent
# /app/node_modules => is an anonymous volume, this enables the change in code to reflect in the container  |------- remove ----|
# docker run  -d -p 3000:80 --rm --name feedback-app -v chosenName:/app/feedback -v "{pathToCodeBase}:/app" -v /app/node_modules feedback-node
CMD [ "node", "server.js" ]