# this project has two services mongo db and express

# when hosting there is no quarantee that your containers will be on the same network like the localhost version when containerizing multi-containers 

# but when they are done in the same task there is high probability of all been in the same network.

# so we can replace the mongo service name with localhost when hosting with aws ecs as both services will be part of the same task 

  `mongodb://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@mongodb:27017/course-goals?authSource=admin`, 
  
  was changes to 

    `mongodb://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@${process.env.MONGODB_URL}:27017/course-goals?authSource=admin`,


#  BUILD THE IMAGE 
docker build -t degreatasaa/goals-node .
#  PUSH TO DOCKERHUB 
docker push degreatasaa/goals-node .

# RUN LOCALLY for testing purposes and in the backgroup but if foreground remove the -d in the command 
docker-compose -d up 

# STOP THE RUNNING CONTAINER AND CREATE A CLUSTER FOR IT IN AWS ECS 
=> GENERALLY CREATE CLUSTER, TASKS THEN SERVICES 
=> CLICK ON THE CLUSTER THEN SELECT CREATE TASK THEN AFTERWARDS CREATE SERVICE FFing ffing
- create cluster use fargate # NB Cluster is just the surrounding network for your containers.
- click on the cluster 
- adding tasks to the cluster # Services are based on tasks so we need to create tasks first. 
- creating task use also fargate for serverless for auto scaling
* click on docker configuration 
   - command: node,app.js
* click on environment variables to your env_variables specified for MONGODB_URL set value to localhost as ecs does not support the feature of docker communicating with containers in same netowrk with the container name. But supports those in the same tasks. as in development localhost will not work and so in production mongodb wont also work.
MONGODB_USERNAME=max
MONGODB_PASSWORD=secret
MONGODB_URL=localhost 

- Adding another container which is the mongodb Container in the same task.

name: mongodb or your preferred name 
imageUrl: mongo # as its an official image in docker 
port: 27017 # default port for mongo db

 * Adding environment variables defined in the mongo.env