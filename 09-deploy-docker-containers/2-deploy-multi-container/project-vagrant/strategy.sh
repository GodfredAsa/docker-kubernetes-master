# Login into the vagrant VM and executed the following 
- install mongo image
docker pull mongo
- run a container of mongo image 
docker run --name mongodb -d mongo
- inspect mongodb and pick Network IPAddress and used it to form the connection string in the backend 
doccker inspect mongodb

- build the image 
docker-compose up --build 

- tag the image 
docker tag imageName dockerhubUsername/imageName
- push to hub 
docker push dockerhubUsername/imageName

- login to VM and pull image
docker pull dockerhubUsername/imageName

- build and image of the and run it 
docker run -p containerPort:hostPort dockerhubUsername/imageName
docker run -p 3000:3000 dockerhubUsername/imageName
 
 command for running the container in Vagrant Box
# docker run -p 3000:3000  degreatasaa/project-vagrant-100