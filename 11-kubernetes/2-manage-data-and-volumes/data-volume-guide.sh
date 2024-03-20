# VOLUMES
- Persistent Volumes and Persistent Volume Claims
- Environment Variables 

# build it locally and test it 
docker-compose up -d --build 
docker-compose down 

# UNDERSTANDING STATE IN K8
 - State is data created and used by your application which must not be lost. READ THE PDF FILE ATTACHED TO THIS SECTION.
#  defining service and deployment files.
# NOTE: B4 you apply the definition files ensure that the image repository is created in dockerhub 
- then build and push the image to dockerhub ensure to always add a tag 
docker build -t degreatasaa/kub-data-demo .
docker push degreatasaa/kub-data-demo

# apply the deployment and service b4 that ensure minikube and virtual machine is app and running using one of the commands 
kubectl apply -f=service.yaml, deployment.yaml
kubectl apply -f=service.yaml -f=deployment.yaml

# verifying 
kubectl get deployment
kubectl get service
kubectl get pods

# accessing the service
minikube service serviceName
minikube service story-service 

# K8 VOLUMES 
- we will configure volumes where we configure pods in the deployment file 

# after adding the code snippet to crash the container and destroy the pod when the error route is visited 
# rebuild the image with the same name. 
# push to dockerhub with a tag different from the previous 
# update the deployment file to use the new image created above. 

kubectl apply -f=service.yaml -f=deployment.yaml


# read the deployment files with the exception of deployment.yaml 
- deployment-emptydir-volume
- deployment-hostpath-colume
- deployment-csi-volume.yaml # contains only instructions 

# PERSISTENT VOLUMES 
- Define once and use it in multiple nodes of a cluster 
- Key concept is the detachment of the volume from the pod life cycle.
- Built around the idea of pod and node independent enable data not to be loss if pod is destroyed.
-  Good for bigger deployments