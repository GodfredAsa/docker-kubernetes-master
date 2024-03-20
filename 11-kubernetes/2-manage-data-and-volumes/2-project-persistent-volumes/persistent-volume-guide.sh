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
|-----------|---------------|-------------|---------------------------|
| NAMESPACE |     NAME      | TARGET PORT |            URL            |
|-----------|---------------|-------------|---------------------------|
| default   | story-service |          80 | http://192.168.49.2:32062 |
|-----------|---------------|-------------|---------------------------|
🏃  Starting tunnel for service story-service.
|-----------|---------------|-------------|------------------------|
| NAMESPACE |     NAME      | TARGET PORT |          URL           |
|-----------|---------------|-------------|------------------------|
| default   | story-service |             | http://127.0.0.1:58294 |
|-----------|---------------|-------------|------------------------|