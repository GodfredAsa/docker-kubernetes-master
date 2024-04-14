
# Previous lessons covered K8 in localhost on our development machines using minikube

# KUBERNETES IN PRODUCTION 
- Deploying Containers with K8s 
# Focus 
- Deployment Options & Concepts
- Example AWS EKS 
# Brief remember that auth-api is not exposed to the public hence ClusterIP used NOTE: Both the service and the deployment definitions are inside the same yaml file.
- create an atlas cloud mongodb account
- create a db cluster at atlas 
- add db security credtails and copy the connection string and update your user security details 
- build the images of both the auth-api and user-api 
- push built images to dockerhub 

# DIVING INTO AWS EKS => ELASTIC KUBERNETES SERVICE 
- EKS is a PAID service 
- login to aws and search EKS  
- CREATE CLUSTER 
  * create cluster service role [IAM] click Roles 
  * search IAM 
  * click Roles 
  * Trusted Entity Type => AWS Service  
  * Service or Use Case => EKS => EKS Cluster
- select role created and leave all fields with default values NEXT
- CONFIGURE NETWORK 
  * Search CloudFormation new tab.
  * create stack
  * copy this url paste at s3: "https://amazon-eks.s3.us-west-2.amazonaws.com/cloudformation/2020-08-12/amazon-eks-vpc-private-subnets.yaml"
  * give stack vps name then NEXT NEXT then SUBMIT
  * return to create cluter page and select the vpc created 
  * cluster endpoint access choose "public and private " all others default 

- CONFIGURING YOUR MACHINE TO BE ABLE TO TALK TO AWS 
  * Install AWS CLI 
  * In AWS account click your account name and download access keys and secrets @ security credentials
  * your root directory 
    + cd .kube
    + make a copy of the config file with a different name for backup probably call config-back
    + such that in the nearest future copy the backup content into the original one config file 
    + create access and secret key 
    + aws configure 
    + ensure cluster us active then run " aws eks --region us-east-1 update-kubeconfig --name kub-dep-demo" which will update the config file a copy was made earlier so that kubectl can talk to aws instead of minikube.
     + kub-dep-demo is the cluster name 
    + now you can run kubectl commands which will talk to your aws cluster instead of minikube 

- ADDING WORKER NODES 
  * In AWS Cluster page click on COMPUTE then click ADD NODE GROUP 
  * for Node IAM ROLE, go to IAM Console and create a node role for that 
    + use case EC2 
    + Addmission Permissions policies below then give a role name and CREATE
      - AmazonEC2ContainerRegistryReadOnly
      - AmazonEKS_CNI_Policy
      - AmazonEKSWorkerNodePolicy
    + select the role created above for the NODE IAM ROLE. NEXT
    + Make changes as needful 
  * CREATE and Ensure the NODES are created and running, Check also whethet their respective EC2's are also created.


- APPLYING KUBERNETES CONFIGs 
   - before applying ensure that you have built your images and pushed to dockerhub 
     kubectl apply -f=auth.yaml -f=users.yaml 
   - kubctl get deployments 
   - test app using the EXTERNAL IPs from the command get above 
   - NOTE: To increase or decreate the number of pods modify the definition files and re-apply 

- ADDING VOLUMES **** DID NOT WORK ****
  - Assuming some part of our code writes to a file called users. this is where we add a volume. But this time we are using k8. 
  - We will use the persistent volume approach using CSI [ Container Storage Interface ] as type read more on this at kubernetes docs while leveraging on aws EFS [Elastic File System] to manage data 
  - Read on integrating CSI with EFS 
    - install EFS driver since EFS is not supported as volume type otherwise.
        kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.7"
        kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.0"
    - create an EFS as it will not be done for us automatically
     - but before that create security group with a befitting name. vpc choose previous vpc created during the cluster
        - add inbound rules, select NFS, source: CUSTOM, find your vpc and copy its IPv4 CIDR address and paste it in. It always an IP address 
        - CREATE SG
    - Return EFS and CREATE
       - give name and select cluster vpc then CUSTOMISE, NEXT to NETWORK ACSESS, remove all security groups and select the security group created just above.
       - NEXT NEXT to CREATE then copy the file system ID: fs-075ae3941584de28e

kubectl get svc 
kubectl get sc # storage classes
kubectl get pv # persistent volumes 
kubectl delete deployment users-deployment


