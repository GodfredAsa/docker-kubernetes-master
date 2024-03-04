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