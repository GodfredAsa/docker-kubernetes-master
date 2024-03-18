# Services refers to containers 
# With docker-compose when a service is stop the container is auto-removed.

# Docker-compose automatically adds all the services to the same network although you could specify 

# Running the docker-compose

docker-compose up -d 

# to force images to be build based on code changes 
docker-compose up --build 

# to just build the images without starting the containers 
docker-compose build 