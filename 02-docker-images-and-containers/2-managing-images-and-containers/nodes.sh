# build new image from Dockerfile 
docker build .

# run the new container at foreground or attached mode with exposed port 3000 external port and 80 internal port 
docker run -p 3000:80 containerName
# alternative to the above you can run 
docker attach containerName or containerID

# run the new container at background or detached mode with exposed port 3000 external port and 80 internal port 
docker run -p 3000:80 -d containerName

# List running containers
docker ps
# List all containers 
docker ps -a

# Lists all docker ps available options 
docker ps --help

# restart a stopped container  containerName or containerID
docker start containerName

# view logs of a container in detached mode 
docker logs containerName 

# run a container in interactive mode using the terminal and example of the dockerising python project.
docker run -it containerID

# start a stop container interactive mode taking user inputs from terminal 
dcoker start -a -i containerName 

# start, run a new container then automatically remove it when stopped.
docker run -p 3000:80 -d —-rm 2ddf2ede7d6c
# inspecting a container 
docker inspect containerID 
# inspect image 
docker image inspect imageName|imageID

# COPYING FILES INTO AND FROM AN IMAGE 
# INTO A CONTAINER
docker cp pathToLocalFileOrDir containerName:/destinationPath
# FROM A CONTAINER 
docker cp containerName:/destinationPath pathToLocalFileOrDir

# NAMING AND TAGGING CONTAINERS 

# Running container with user defined container  
 docker run --name containerName containerBuildID

# build an image with name and tag 
docker build -t imageName:tag . # Example: docker build deskbookr:V1 .
# then you can rebuild with different tags Eg. docker build deskbookr:V2 .



