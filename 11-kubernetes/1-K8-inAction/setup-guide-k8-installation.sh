# INSTALLING K8 LOCALLY REQUIREMENTS
# Installing Kubernetes with Minikube
- for setting up dummy cluster locally we need to use minikube 
- for playing with K8 locally 
- will install kubecontrol which is kubectl and minikube 


# INSTALLING 
- install kubectl either with homebrew or binary format from the url: https://minikube.sigs.k8s.io/docs/start/
- install hypervisor eg VirtualBox
- install minikube either with homebrew or binary format 
- check minikube installation  with --driver=virtualbox or --driver=docker
minikube start --driver=docker

# sample commands 
minikube status 
minikube start
# dashboard service
kubectl get services --namespace=kubernetes-dashboard
kubectl get pods --namespace=kubernetes-dashboard
kubectl logs --selector=k8s-app=kubernetes-dashboard --namespace=kubernetes-dashboard
kubectl delete pods --selector=k8s-app=kubernetes-dashboard --namespace=kubernetes-dashboard
kubectl describe pod kubernetes-dashboard-8694d4445c-99d9k --namespace=kubernetes-dashboard
kubectl logs kubernetes-dashboard-8694d4445c-99d9k -c kubernetes-dashboard --namespace=kubernetes-dashboard

# view dashboard 
minikube dashboard 
minikube dashboard --url  # gives the accessible dashboard

# UNDERSTANDING KUBERNETES OBJECTS
- K8 works with Objects Eg. Pods, Deployment, Services, Volume ...
- Objects can be created in 2 ways IMPERATIVE & DECLARATIVE 

# KEY OBJECTS 

# 1. POD 
- smallest unit K8 know and interactive with 
- containers or runs one or multiple containers 
- contains shared resources Eg. volumes 
- has cluster internal IP Address used to send info the container running in the pod 


