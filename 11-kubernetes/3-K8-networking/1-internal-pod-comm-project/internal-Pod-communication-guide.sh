# THIS GUIDE IS FOR INTERNAL POD COMMUNICATION 
# The main relevance of this is to do container communication by network.
- contains 3 different apps that work that will work together
- build images using docker-compose.yaml and test locally.
docker-compose up  -d --build 

kubectl delete service story-service
kubectl delete deployment story-deployment

# Deploying the apis to kubernetes 
# START WITH USERS API 
- make small modifications 
- build user api image 
docker build -t degreatasaa/kube-demo-users .
- push the image to dockerhub 
docker push degreatasaa/kube-demo-users

- created dir called kubernetes to store definition files 
- worked on user-deployment.yaml file and apply it.

kubectl apply -f=users-deployment.yaml
- check if it works 
kubectl get deployments

- Services: Allows us todo 2 main things 
  * Gives a stable IP addresses 
  * Configured to allow outside world access.
  ** LoadBalancer: The "most useful" type if you need "outside world access" to the Service and its Pods.
  ** ClusterIP is meant for internal communication among Pods in a service.
  ** Search differences between NordPod, LoadBalancer, ClusterIP

- defines users-service.yaml file and applies it 
kubectl apply -f=users-service.yaml 

- accessing the service with minikube 
minikube service service-name
minikube service users-service

# Multiple Containers in one Pod 
- Implementation. Letting the users api communicate with the auth api.
  * edit the users-api service and return it back to the previous code that you just commented and use env vsriables.

  * edit docker-compose.yaml file to include the environment vars 

  * build the auth api image and push to hub.
    docker build -t degreatasaa/kube-demo-auth .
    docker push degreatasaa/kube-demo-auth
  * use the image to create containers in K8 Pods
    we could create a different deployment but we want the auth api in the same Pod as the users api so shouldnt be in a separate Pod.

    if we create a different deployment for the auth api it will result in a different Pod. So in the users-deplotment will add another container which is the auth. and add tags to both which the latest as K8 refetches the image and re-evaluate it when the tag latest is used and there is changes.

    We did not expose a port for the auth container bcos we dont want it to be accessed by the outside world.

    - rebuild the users image and push to hub 
    - as at now the user-api and auth-api reside in the same pod but different container.

    # NOTE: When 2 or more containers run in the same Pod K8 allows sending the request to the localhost then using the port exposed by the other container. So localhost is the magical address you can use inside of a pod. 

    * with this understanding we add the need AUTH_ADDRESS env-var to the users-deployment.yaml definition file.

    * apply the users-deployment.yaml file which is updated.

    kubectl apply -f=users-deployment.yaml
    kubectl get pods
# ======================================================================== 
    NAME                               READY   STATUS        RESTARTS   AGE
users-deployment-6cb4f4b5b-n98xd       2/2     Running       0          25s
users-deployment-7c45f9fdd-zshrz       1/1     Terminating   0          83m
# ======================================================================== 

# CREATING MULTIPLE DEPLOYMENTS 
