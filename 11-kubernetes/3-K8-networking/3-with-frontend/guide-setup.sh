# Adding a frontend app to the deployed services 

- build the frontend image 
docker build -t degreatasaa/kube-frontend-app .
- push to dockerhub 
docker push degreatasaa/kube-frontend-app 
- trial: trial with a local container first 
docker run -p 3000:80 --rm degreatasaa/kube-frontend-app

# DEPLOYING THE FRONTEND NOW ON KUBERNETES 
- create frontend-deployment.yaml file and specify 
- add service exposing it to the public 
- create frontend-service.yaml file use LoadBalancer
- apply the definition files 
kubectl apply  -f=frontend-service.yaml -f=frontend-deployment.yaml 

minikube service frontend-service # to view the deployed service

# Instead of hard coding the server url in the frontend of the client. We are learning what we call reverse proxy.
- added the snippet in the nginx.conf file 
  location /api {
    proxy_pass http://127.0.0.1:60530;
  }

  - removed the hard coded backend url from the client to /api/ and whatever the variable is. 
  - rebuild frontend image and push to dockerhub for kubernetes to be able to use the image. 
  - delete the frontend deployment and reapply to fetch the latest code 

#   An issue is raised as the port keeps changing and the reverse proxy is executed inside the container BUT The key thing is that we can replace the proxy_pass with the serviceName which in this case was task which is the backend url the client was consuming as its cluster internal and are domain name generated internally based on a service. where 8000 is the task backend export port.

  location /api/ {
    proxy_pass http://task-service.default:8000/;
  }

#   we could also use in when deployed to aws it has nothing to do with K8.
- rebuild the frontend image and push 
- delete the old frontend deployment and redeploy 
- apply the frontend deployment again 
