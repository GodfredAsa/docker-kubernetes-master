# BUILDING UTILIY CONTAINERS 
# Usually utility containers do not contain the project to be containerised.
# It we start by creating Dockerfile in an empty directory  

# Dockerfile
# node version used is 14-alpine which is extra slim and optimised node image as its just a utility container 
# After the first 2 lines of command thus the FROM and WORKDIR 

# RUN
- build the node-alpine image 
docker build -t node-util 
- build the container from the image in interactive mode and mirror it into your host machine so we can create a project on the host machine with the help of the container. Thus the idea of having a utility container so it can be used to execute something on the host machine that has an effect on both the container and host machine. To achieve this we use a bind mount.
pathToFile="/Users/macintosh/Documents/WORKING FILES /Learnings/docker-kubernetes-master/07-working-utility-containers/utility-project-setup/Dockerfile"
docker run -it -v pathToFile:/app node-util npm init 
# answer some few questions and the package.json file is added to the directory.

# Utilizing Entrypoint 
# Making it restrictive to only npm commands 
- added ENTRYPOINT to the Dockerfile 

# DIFFERENCES BTN ENTRYPOINT AND CMD Dockerfile commands
- Entrypoint commands is appended to the end of the commands written in the cli while with CMD if there a command written in the cli it overrides that in the Dockerfile.


docker build -t my-npm
docker run -it -v pathToFile:/app my-npm init # npm will be appended b4 the init due to entrypoint in dockerfile
- to install npm in the container
docker run -it -v pathToFile:/app my-npm install

- installing express
docker run -it -v pathToFile:/app my-npm express --save


# USING DOCKER COMPOSE FOR THE ABOVE 

- create a doccker-compose.yaml file and define services
# NB: No need to have package.json in the project as it will be create by the command.
- to run the docker-compose  for utility 
docker-compose run serviceName # Eg below

docker-compose run --rm npm init
docker container prune # removes all unused containers