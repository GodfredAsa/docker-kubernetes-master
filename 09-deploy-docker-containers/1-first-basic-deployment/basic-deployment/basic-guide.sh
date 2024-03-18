docker build -t basic-node-img . 
docker run --name basic-node-app  -d -p 81:80 --rm basic-node-img


# ================== DEPLOYMENT OF FIRST BASIC APP TO EC2 ON AWS =============================
# AMI: Amazon Linux 2 AMI 
-  installing docker om amazon linux 
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo chkconfig docker on
sudo docker --version
sudo usermod -aG docker your_username

# STRATEGY USED TO DEPLOY FIRST APP TO AWS ON AMAZON LINUX 
- build image and container locally and pushed to dockerhub
- pull container from docker hub and build and run 

steps 
- login to dockerhub 
- create repository and give it a name eg. first-app
- open a terminal not login to amazon ami 
- create a .dockerignore file and ignore the ffing 
   - node_modules
   - Dockerfile
   - *.pem if in directory of project.

- build the image with the same name as created at dockerhub Eg. first 
docker build -t first-app .
- renaming image format: docker tag containerName degreatasaa/containerNameAsAtHub
docker tag first-app degreatasaa/first-app
- push image to dockerhub
docker push degreatasaa/first-app 

# Running and publishing the image on the remote machine which is amazon linux ami 
- login to remote ami
- run the command below 
docker run -d --rm -p 80:80 degreatasaa/first-app 

# Adding updates 
rebuild the image locally and change the name and push to dockerhub 
login to the cloud ami 
stop the running container and push from the dockerhub.