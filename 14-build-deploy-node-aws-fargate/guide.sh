# AWS ECR => Elastic Container Registry 
- create repository 
- click repository name and click "view push commands"
  - contains the commands to run to push image to aws ecr 
- run all the listed commands one after the other 

# after this you should the image uploaded to aws
# SETTING UP ELASTIC CONTAINER SERVICE CLUSTER  [aws ECS]
- creating the aws fargate cluster 
- network only cluster and dont provision vpc use the default provision.
- create a task definition 
   - should be a fargate one 
   - select the appropriate memory and cpu power 
   - adding a container: for the image url go to ECR select the image and copy its url and paste at the image url section in the task creation definition.
- select the cluster and click service, create a service 
   - select fargate 
   - use the default vpc and select all the provided subnets under networks
   - create security group 
     - select custom tcp, port: 3000, anywhere 
     - load balancer: ALB => Application Load Balancer. create one at the ec2 service 
        -  internet facing [HTTP & HTTPS]
        - application load balancer port should be the default for the internet which is 80 & protocol HTTP
    - create new security group inbound rules Custom TCP Port:80 Anywhere.
    - create target group
      - target type: IP Addresses

# SETTING UP CUSTOM DOMAIN NAME WITH THE LOAD BALANCER url 
- ROUTE 53 is the AWS service for Domain Name mapping 
- if you dont have a domain click register domain 
- hosted zones and select one of the zones 
- create new record 
  - Routing policy: Simple routing 
  - Record name: appName
  - Alias On.
  - Route Traffic to: Alias Application Load Balancer
  - choose region
  - select the load balancer
  - create or save record and use the route 53 provided url 
