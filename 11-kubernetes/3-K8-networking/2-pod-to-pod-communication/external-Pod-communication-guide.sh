# CREATING MULTIPLE DEPLOYMENTS AS SHOWN ON THE LAST SLIDE 

- writing a separate deployment file for the auth-api so both it and users-api dont reside in the same container

- With services you get stable IP Address.

- apply the definition files 
kubectl apply -f=auth-service.yaml -f=auth-deployment.yaml

- getting the stable IP addresses of the services 
kubectl get services # pick the IP Address relating to the auth service and put in place of localhost of the env of the users-deployment.yaml and apply the change to it 

NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
auth-service    ClusterIP      10.104.31.223   <none>        80/TCP           5s
kubernetes      ClusterIP      10.96.0.1       <none>        443/TCP          4d3h
users-service   LoadBalancer   10.100.210.33   <pending>     8080:30510/TCP   11h

- But manually doing the replacement of IP address is not a good but Hence there is a better to handle this. K8 already give some environment vars when objects are applied. 

- Syntax is the serviceName all Capitalised and dash (-) converted or changed to underscore (_) and appended with _SERVICE_HOST

- EG asumming the service name is users-service will now become USERS_SERVICE_SERVICE_HOST and is the service name is auth-service -> AUTH_SERVICE_SERVICE_HOST and should be used in the app as env vars. But to ensure it also works with Docker you will need to change the docker env to match the new syntax .

- with this change rebuild the users-api and push to docker then apply the deployment 

minikube service serviceName # to get api for the service 


docker build -t degreatasaa/kube-demo-users  .
docker push degreatasaa/kube-demo-users
kubectl delete -f=users-deployment.yaml
kubectl apply -f=users-deployment.yaml

# BRIEF: For the login request we were using the auto-generated K8 service-host env var 

###### USING DNS FOR POD TO POD COMMUNICATION 

- The domain names in K8 refers to the service names and can be used to replace the Unchanging IP Address. 

# View namespaces 
kubectl get namespaces 
# currently our namespace is the default
- Generating syntax serviceName.NAMESPACE EG. service-name.default 
auth-service.default 
# can be used inside the cluster sending requests to our containers as done in users-deployment.yaml 

- apply the changes in of the users-deployment.yaml 

# CONTAINERIZING TASK API 
# NOTE NOTE: Use LoadBalancer if the container needs to reach from out of the cluster example hit it with postman. hence why some of of the services we used the type as LoadBalancer.
docker build -t degreatasaa/kube-demo-tasks .
docker push degreatasaa/kube-demo-tasks

- apply definition files - task 
kubectl apply  -f=tasks-service.yaml -f=tasks-deployment.yaml