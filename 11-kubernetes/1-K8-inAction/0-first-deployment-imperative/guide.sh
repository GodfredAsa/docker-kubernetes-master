- Need to use docker to create an image first as K8 is all about containers and inorder to run containers docker must be used to create the image of the container to run. The only difference with K8 is that you dont create your containers on your own anymore. K8 does it. Hence the addition of a docker file 

# USING IMPERATIVE APPROACH
- build the image with custom name 
docker build -t dockerhubUsername:preferresImageNmae .
docker build -t degreatasaa:kub-first-app .
- push image to dockerhub registry 
# NOTE:m If image is created without ffing the rules it will be created will not run when the deployments, pods is accessed. Hence the need to.
- to create deployment objects ensure the cluster is running 
kubectl create deployment deploymentName --image=imageNameFromDockerhub
kubectl create deployment first-app-deploy --image=degreatasaa:kub-first-app
# view the deployments in the dashboard 
minikube status 
minikube start 
minikube dashboard --url

- get deployments, pods 
kubectl get deployments
kubectl

- deleting deployments
kubectl delete deploymentName

# Exposing a Deployment with a Service
kubectl expose deployment deploymentName --port=appPort
# --type=ClusterIP reachable within the cluster
# --type=NodePort 
# --type=LoadBalancer distributes incoming traffic across all Pods part of the service. it supports where the infrastructure supports ie. aws and also minikube also supports

kubectl expose deployment first-app-deploy --type=LoadBalancer --port=8080

kubectl get services # lists of services when using minikube with th External IP always <pending> but with cloud providers like a aws it will be displayed there for accessing the service. The main reason why minikube does not show it is that its a VM running on our local machine. But it has a command that enable us to run and access the service on the local machine.

minikube service first-app-deploy # dont need this commnd when you use a cloud service provider as its minikube specific. it should provide a table with headings NAMESPACE | NAME | PORT | URL . And opens automaticallly in the browser 


# RESTARTING CONTAINERS 
- with this deployed express app when you visit /error the app clashes and the pod is destroyed but since we deployed using Deployment Object it automastically span an other pod in its place and brings its to live without interferance.

# SCALING IN ACTION 
- assumining we begin to get high number of traffics and we need to scale up which means to increase the number of pods. Bcos we have load balancer traffic will be distributed evening among the scaled pods.

# Scaling up, to scale up repeat the command with more replicas
kubectl scale deployment/first-app-deploy --replicas=3

# scaling down, to scale down repeat the command with less replicas
kubectl scale deployment/first-app-deploy --replicas=1

kubectl get pods 

# UPDATING DEPLOYMENTS WITH 
- Assumining you made code changes and need to update the code on the live server or production.
- rebuild the image using the same name as previous but give it a TAG.
- push the built image to dockerhub 

- updating the deployment. NOTE: New Images are ONLY UPDATED if they have a different TAG
kubectl set image deployment/[DEPLOYMENT_NAME] [CONTAINER_NAME]=[NEW_IMAGE_NAME]
[DEPLOYMENT_NAME]: Name of the deployment to update.
[CONTAINER_NAME]: Name of the container within the deployment.
[NEW_IMAGE_NAME]: New image to use for the specified container.

kubectl set image deployment/first-app-deploy kub-first-app=degreatasaa/kub-first-app:v1
kubectl set image deployment/my-deployment my-container=mynewimage:v1

- verify the roll out 
kubectl rollout status deployment/oldDeploymentName
kubectl rollout status deployment/first-app-deploy

# ROLLING BACK UPDATED IMAGE.
- Checking roll out status 
- assuming you try top update a deployment with an invalid image or image was not uploaded to dockerhub 
kubectl rollout status deployment/deploymentName
kubectl get pods 
NAME                           READY       STATUS            RESTART   AGE 
first-app-64f44b744d-xgg6f     0/1         ImagePullBackOff    0       2m31s

# - roll back the deployment this undo's the latest deployment 
kubectl rollout undo deployment/deploymentName
# - you can check the pods and also status of the deployment.

# Deployment History 
kubectl rollout history deployment/name 
REVISION CHANGE-CAUSE
1
3
4

# review details about specific deployment history
kubectl rollout history deployment/first-app —-revision=3

# rolling back to a specific revision 
kubectl rollout undo deployment/deploymentName --to-revision=1

# DELETING SERVICE AND DEPLOYMENT 
kubectl delete service first-app
kubectl delete deployment first-app