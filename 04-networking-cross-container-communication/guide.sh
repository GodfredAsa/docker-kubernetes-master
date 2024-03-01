# CONTAINERS AND NETWORKS 
# networking refers to container communication and how you can make containers accessible to everyone on the web
# this can be referred to as connecting containers 
# FOCUS OF THE STUDY 
- containers and external networks 
- connecting containers with networks 

# CONTAINERS AND NETWORK REQUESTS 
- Network request refers to a container being able to reach other applications not within its container.
- container to localhost machine communication: this refers to communicating with services within the host machine. Example is a database running on our machine without docker.
- short summary: there are 3 levels of communication established 
  - communication between a container and the www 
  - communication within a container and a service within the container like db
  - communication between containers Eg.  restful containerised service communicating with a containerised db.
# NB: Its a best practice to follow single responsibility principle: Assumining you have a service comprising of a database the application logic. By SRP you need to containerise the db separately and also the application service separately then enable communication between them.

# CONTAINERISING NETWORKS AND CROSS CONTAINER COMMUNICATION
# Creating a container and communication to the web | www
- out of the box containers can communicate to the world wide web.
# Making Container to host communication Work
- change the mongodb connection string localhost to host.docker.internal and ensure mongo is installed on docker and is running 
- new mongo db connection url should look like this => mongodb://host.docker.internal:27017/swfavorites

#  CONTAINER TO CONTAINER COMMUNICATION
- containerise the mongoDB and the app hence making II containers instead of one 
- install or pull mongo image and name it mongodb, run it and inspect it using the command below
docker inspect mongodb
- search the NetworkSettings shows the IPAddress of the install mongo ==> docker inspect mongodb | grep IPAddress
- copy the IPAddress value '172.17.0.2' and replace it with the localhost or 'host.docker.internal' in the app mongodb 
- connecting url  
# Although this idea works its not recommended but there is good way of doing this.

################# Docker Networks also known as Just Networks or container container communication. ##############
- with docker you can put all of the containers in the same network by running the containers with the following options 
docker run --network my_network # this groups the containers in the same network and enable them to talk to one another.
# STEPS: unlike volumes docker does not automatoically create networks for us. We need to create it ourselves.
- create a network NB: this is a docker internal network that can be used in containers.
docker network create giveNetworkName # Eg. docker network create foodapp-network. 
docker network ls # List all networks 
- create the mongodb container with the network created above
docker run --name mongodbName --network createdNetworkName  -d mongo
- replace the IPAddress or localhost or host.docker.internal in the app url with the name of the given mongodb created above Eg. 'mongodb://mongodbName:27017'
- run a container also for the app using using the same network as the mongoDB container instance.
# NB: When using container to container connecting via common network DO NOT EXPOSE ANY PORT OR PUBLISH IT WHEN SPUNNING THE CONTAINER FOR THE WEB APP.