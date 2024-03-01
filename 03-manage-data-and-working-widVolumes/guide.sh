# MANAGING DATA IN IMAGES AND CONTAINERS 
# this includes 
- Writing
- Reading 
- Persisting Data 
# this lesson focuses on 
- Images, Containers and Volumes 
- Using arguments and Env variables 

# FIRST SETUP FOR 1-data-volumes-temp-permanent with file systems
- build image with userName
docker build -t feedback-node .
- run container out of the image with custom container name such that when its stopped automatically deletes 
- the port 80 is what is exposed or used in the application itself in the server.js
docker run -p 3000:80 -d --name feedback-app --rm feedback-node
# when the container is removed the data in the file is also lost 
# which means saved data is actually removed or loss once the container is removed 
# this issue persists even if a new container is spawn inplace of the previous without codebase change.
# NOTE: Multiple containers based on the same image works in isolation 

# VOLUMES 
- deals with issue raised by data persistents even when containers are removed or destroyed.
NB: Volumes are folders on your host machine hard drive which are mounted (made available) into containers 
                                                       ________________________
                                                      |     named volume      |
# Creating a container with a named volume            |-----------------------|
docker run  -d -p 3000:80 --rm --name feedback-app -v chosenName:/app/feedback feedback-node
# named volume are not attached to containers 

# Lists all volumes 
docker volume ls 


# BIND MOUNT
# pathToCodeBase: /Users/macintosh/Documents/WORKING FILES /Learnings/docker-kubernetes-master/03-manage-data-and-working-widVolumes/1-data-volumes-temp-permanent
# /app/node_modules => is an anonymous volume, this enables the change in code to reflect in the container 
docker run  -d -p 3000:80 --rm --name feedback-app -v chosenName:/app/feedback -v "{pathToCodeBase}:/app" -v /app/node_modules feedback-node


# CREATE VOLUME and mount as a named volume 
docker volume create volumeName
docker run  -d -p 3000:80 --rm --name feedback-app -v volumeName:/app/feedback -v "{pathToCodeBase}:/app" -v /app/node_modules feedback-node

# delete volume 
docker volume rm volumeName


# adding .dockerignore file to ensure certain files and folders are not copied to the image 


# WORKING WITH ARGUMENTS AND ENV VARIABLES 
- Running a container with port as ENV 
docker run  -d -p 3000:80 --rm --name feedback-app --env PORT:80 -v chosenName:/app/feedback -v "{pathToCodeBase}:/app" -v /app/node_modules feedback-node
# NB: With multiple EVNs just start each with --env or --e folloed the variable and its value eg. --env PORT=80 --env NAME=food-deliverer

# SPECIFYING A FILE CONTAINING YOUR ENV VARIABLEs
docker run  -d -p 3000:80 --rm --name feedback-app --env-file ./.env -v chosenName:/app/feedback -v "{pathToCodeBase}:/app" -v /app/node_modules feedback-node

# USING BUILD ARGUMENTS 

- Build with default args port 
docker build -t feedback-node:web-app .

docker build -t feedback:web-app --build-args .

- Building with a different defualt port for dev environment 
docker build -t feedback:dev --build-arg DEFAULT_PORT=8000 .
