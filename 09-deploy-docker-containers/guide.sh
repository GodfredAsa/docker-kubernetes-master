# FOCUS WEB APP DEPLOYMENT 
# MODULE CONTENT 
- Deployment Overview & General Process
- Deployment Scenarios, Examples and Problems

# ================  DEVELOPMENT TO PRODUCTION ================
- Bind Mounts should not be used in production!. 
- Containerised apps might need a build step e.g. react apps  

# A BASIC FIRST EXAMPLE: STANDALONE NODEJS APP

# DESCRIPTION: NodeJS application, no database, nothing else.


# DEPLOYMENT ON AUTOMATED SERVICECS 
- self managed services eg ec2. Managed by self and maintenance as well. 
- managed services  eg AWS ECS => Elastic Container Service.
For managed services such as ecs the Creation, management, updating is handled automatically, monitoring and scaling is simplified

# DEPLOYING WITH AWS ECS A MANAGED DOCKER CONTAINER SERVICE.
- search ecs  
- create a task
- create a service 
   - select the task => Actions => Create Service 
   - launch type: fargate 
   - load balancing: Application Load Balancing  
- repository_url refers to your dockerhub [ username/project_name ] easily seen in dockerhub in relations to the specific project.

- UPDATING CONTAINER ON ECS 
  -  build the image again 
        docker build -t imageName .
  - replace the image name as the old name or tag the image name 
        docker tag imageName dockerhubUsername/projectName
  - push to dockerhub 
        docker push dockerhubUsername/projectName
  - Making ECS Aware of the image update 
     clusters => default => tasks => task_id 
     - click create new revision 
     - click actions then select UPDATE SERVICE 
     - click SKIP TO REVIEW, UPDATE SERVICE 
An alternative would be to NOT create a new task revision but just use "Update Service" and select "Force new Deployment"


# PREPARING A MULTI CONTAINER APP 
- refer to its guide in the 2-deploy-multi-container dir
- Also when creating the clusters, tasks and services ensure the that the healthcheck path is /goals which the default path to the app instead of the / which is not been used by the app.
# After deploying containers or in the process of deploying containers you can attach volumes to ensure data is persisted and not loss when instances or services are started. to do the this select the current service, add new revision, volume give a name and select EFS => Elastic File System, which allows attachment of hard-drives even if the containers are haulted or destroyed.
# ensure to create a security group for the EFS and add the security group of the app.
# in the network access of the NFS use the security group of the EFS 

# SIDE NOTES
- When dealing with databases in production then there is the need to look at scaling, performance and backups and security hence the need to consider db services such as RDS on aws and MONGODB atlas. 
- when using this approach use the mongo db containerisation for dev and may be mongodb  Atlas for prouction
