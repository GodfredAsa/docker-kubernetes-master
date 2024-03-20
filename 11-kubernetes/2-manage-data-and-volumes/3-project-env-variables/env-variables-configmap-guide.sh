- first define a persistent volume definition 
- define claims definition 
- a claim is also a resource 
# NB: In  k8 everything is a resiource 

Make good use of the docs 
# view storage classes
kubectl get sc 

# APLYING ALL THE DIFINITION FILES 
1. build image 
   docker build -t degreatasaa/kube-app 

2. push image to dockerhub 
   docker push imageName

3. apply definition files  ensure minikube or cluster is running

    - volume 
    apply the persistent volume 
    kubectl apply -f=host-persistent-vol.yaml

    - claim 
    apply the claim 
    kubectl apply -f=persistent-volume-claim.yaml

    - apply service 
      kubectl apply -f=service.yaml

    - deployment 
    apply the deployment
    kubectl apply -f=deployment.yml
  
  kubectl delete deployment deploymentName
  kubectl delete service serviceName

# Views 
kubectl get pv # persistent volume 
kubectl get pvc # claims 

# ACCESSING THE DEPLOYED LOCALLY USING MINIKUBE 
minikube service serviceName
minikube service story-service   


# USING ENVIRONMENT VARIABLES 

- In app.js line 9. the folder-name was changed to an env variable and reference in the deployment.yaml from line 18 - 20 ensuring the names match.

# IF THE APP HAS ALREADY BEING DEPLOYED THEN AFTER MAKING THE CHANGES FOLLOW THIS GUIDE 

- build the image with new tag 
- apply the deployment definition file. 

# CONFIG MAPS 
- This deals with not wanting to have your env variables in the deployment definition files but rather in a separate file so that different containers can utilise the same environment variables.

- environment-vars.yaml file added 

- apply the env definition file 

kubectl apply -f=environment-vars.yaml
# view 
kubectl get configmap

- apply the deployment 