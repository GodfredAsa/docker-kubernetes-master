# MULTI CONTAINER APPLICATIONS GUIDE || READ THE DEPLOYMENT REQUIREMENT.
- This guide is meant for applications that have database, api service and client app 
- Combining Multiple Services To One App
- Working with Multiple Containers

# 1. DOCKERISING MONGODB SERVICE
docker run --name mongodb --rm -d -p 27017:27017 mongo
- replaced the connection string with 'host.docker.internal' as in previous lessons

# 2. DOCKERISING NODE 
- define Dockerfile # refer to this file in the backend to understand how it was done.
docker build -t goals-express-backend-image .
docker run -—name goals-express-backend-container -—rm -d -p 3000:3000 goals-express-backend-image
# 3. DOCKERISING THE REACT APP 
- defined Dockerfile
docker build -t goals-react .
docker run -—name goals-frontend-container -—rm -d -p 3000:3000 -it goals-react # with react the '-it' is required to for the server to run wihout quitting.

================================== FOLLOW THIS PROCESS =========================
# NB: THE ABOVE SETUP IS FINE BUT ITS BEST THEY ALL RUN IN THE SAME NETWORK SO WILL SET IT UP AS 
#  ADDING DOCKER NETWORKS FOR EFFICIENT CROSS CONTAINER COMMUNICATIONS
docker network ls # List available networks 

docker network create goals-network # creating a network with the name 'goals-network' 
# Now create the different containers with the network created. Also know that when containers are in the same network we need not to push them with ports 
- DOCKERISE MONGODB IN THE NETWORK CREATED
docker run --name mongodb --rm -d  --network goals-network mongo

- DOCKERISE THE API SERVICE WIHT THE NETWORK ALSO CREATED
# NB: REMEMBER TO CHANGE THE MONGODB CONNECTION STRING IN BACKEND, THATS REPLACE localhost or host.docker.internal = mongodbServiceName
# which in this case is 'mongodb' as on line 27 above ===> "mongodb://mongodb:27017/ course-goals"
# We publish the port so the react-app can communicate with it 
docker build -t goals-express-backend-image .
docker run -—name goals-express-backend-container —rm -d --network goals-network -p 80:80 goals-express-backend-image

- DOCKERISE THE FRONTEND REACT APP
# REBUILD THE IMAGE AND THEN SPUN THE CONTAINER FOR IT
# with react the '-it' is required to for the server to run wihout quitting. With the react app you need to publish the port 
# NB: With react the code does not run in the container but rather in the browser.
docker build -t goals-react .
docker run -—name goals-frontend-container -—rm -d --network goals-network -p 3000:3000 -it goals-react 

=========================== ADDING DATA PERSISTENCE TO MONGODB WITH VOLUME AND LIMITING ACCESS  =================================
# SCENARIO: When the mongdb container is stopped and spun again any data persisted earlier is loss hence the need to persist the dat with volumes to resolve this issue.
# The Solution is to detach the data from the container and keep it to the harddrive such that the data survives when the container is torn down. this is attached by adding a volume.

# Dockerise mongodb with persistent volume with named Volume.
docker run --name mongodb --rm -d -v data:/data/db --network goals-network mongo


========================= LIMITING ACCESS BY SECURING THE MONGO DB 
# READ ON AUTHENTICATION IN THE OFFICIAL MONGO DB IMAGE DOCS AT DOCKERHUB
# This involves creating the mongo db instance with root username and password for ensuring security of the mongodb.
docker run --name mongodb --rm -d -v data:/data/db --network goals-network -e MONGO_INITDB_ROOT_USERNAME=fredAdmin -e MONGO_INITDB_ROOT_PASSWORD=fredPass mongo
# after this the REST API server will not be able to connect to the mongodb as its secured now we need to make a minor change to the connection string ffing this 
# unlined format which is the baseUrl 'mongodb://MONGO_INITDB_ROOT_USERNAME:MONGO_INITDB_ROOT_PASSWORD@mongodb:27017/course-goals?authSource=admin'
# Example mongodb://fredAdmin:fredPass@mongodb:27017/proshop?authSource=admin as the baseUrl for the backend or server connecting to the mongodb instance.
# NB: Rebuild the server or backend image 

======================== VOLUMES, BIND MOUNTS AND POLISHING FOR NODEJS APPLICATIONS 
# THIS IS FOR LIVE SOURCE CODE UPDATES ON THE CONTAINER AS WELL WHILE WORKING 

- ADDING A VOLUME FOR THE LOG FILES FOR THE BACKEND SERVER TO ENSURE THE DATA IS NOT LOST WHEN THERE IS CONTAINER TEAR DOWN 
- pathToApp: "/Users/macintosh/Documents/WORKING FILES /Learnings/docker-kubernetes-master/05-building-multi-container-app-docker/project-setup/backend"
#  this is to ensure whenever we make changes to source code it reflects in the container.
# /app/node_modules anonymous volume ensures that the node modules not in not our working directory not not override the one in the container 
docker run -—name goals-express-backend-container —rm -d --network goals-network -p 80:80 -v pathToApp:/app -v logs:/app/logs -v /app/node_modules goals-express-backend-image

# since in the Dockerfile of the node when the container is launched the app is also started the change in code is not reflected in the container code. Hence we need to handle this change with 'nodemon' which will restart the server automatically when the code changes.

- Adding the setup
#  in the package.json add this after the author
#   "devDependencies": {
#     "nodemon": "3.1.0"
#   }

# in the scripts of the same package.json, add the code beneath the test
"start": "nodemon app.js" #hence should look like this 
#   "scripts": {
#     "test": "echo \"Error: no test specified\" && exit 1",
#     "start": "nodemon app.js"
#   },
# finally in the Dockerfile of the backend change the CMD to 
# CMD [ "nodemon", "start" ]

# SETTING ENV VARIABLES FOR THE USERNAME AND PASS 
# 
# ENV VARIABLES SET IN THE DOCKERFILE WITH DEFAULT VALUES 
ENV MONGODB_USERNAME=root
ENV MONGODB_PASSWORD=secret
# NEW CONNECTION STRING 
  `mongodb://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}:27017/course-goals?authSource=admin`,
# 
# RUNNING A MONGODB CONTAINER SETTING USERNAME AND USING THE DEFAULT PASSWORD 

docker run --name mongodb --rm -d -v data:/data/db --network goals-network -e MONGODB_USERNAME=fredAdmin mongo

# Finally ensure the ffing files are not copied into the container 
- node_modules
- Dockerfile
- .git 

============ LIVE SOURCE CODE UPDATES FOR THE REACT FRONTEND APPLICATION 
# hostPath: "/Users/macintosh/Documents/WORKING FILES /Learnings/docker-kubernetes-master/05-building-multi-container-app-docker/project-setup/frontend/src"

# use only hostPath
docker run -—name goals-frontend-container -v ${hostPath}:/app/src -—rm -d -p 3000:3000 -it goals-react 