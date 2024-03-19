# DECLARATIVE APPROCH WE USE FILES WHICH ARE YAML FILES 

- creating deployments using deployment.yaml
docs: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

- run this after defining the deployment.yaml file 
kubectl apply -f=deployment.yaml


# first deployment.yaml definition file  
# Writing a service.yaml resource  and creating 
kubectl apply -f service.yaml 
# backend is the service name under metadata as defined in the definition file.
minikube service backend

# UPDATING AND DELETING RESOURCES 

- To scale up and down the make the needed changes on the number of replicas and apply to take it. Instance scaling up make the replicas 3 and run the command below

kubectl apply -f=deployment.yaml

- making changes to the image update the tag and apply the command on the definition file to reflect changes.
kubectl apply -f=deployment.yaml

# DELETING RESOURCES 
kubectl delete -f=deployment.yaml

# deleting multiple 
kubectl delete -f=deployment.yaml, service.yaml 
or 
kubectl delete -f=deployment.yaml -f=service.yaml 

# COMBINED DEFINITION FILES INTO ONE master-deployment.yml

copy the code for the creating deployments into the master yaml file and also copy the service yaml file content into it as well. NOTE: Lets a good practice to let the service code come first separated with 3 --- lines as seen in the code.

kubectl apply -f=master-deployment.yaml 
minikube service backend 

# MORE ON LABELS OF SELECTORS 
- used to connect other resources to a resource Eg. pods then to deployments as described in deployment definition files.

- or connect PODs to service  

deleting by label 

# You must specify the labels of deployment also in the service 

deployment.yaml                              
metadata:
  name: second-app-deployment                
  labels:
  group: example


service.yaml 
metadata:
  labels: 
  group: example 

  # apply that 

  kubectl apply -f=deployment.yaml, service.yaml 
# deleting by labels and specifying the type of Objects being deleted with gexample as grouo labels.
  kubectl delete -l deployments, services group=example 