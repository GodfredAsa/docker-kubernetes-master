# Use mongoDB atlas which is a cloud service.
# Strategy used is multi-stage builds 
- multi stage build allows you to have one dockerfile but with multiple build steps 
- bcos we deployed on the same server we dont have need the base url for the the backend hence changing to /goals 

docker build -f frontend/Dockerfile.prod -t degreatasaa/goals-react ./frontend
docker push degreatasaa/goals-react

# deploying the frontend degreatasaa/goals-react to aws ecs 


# NOTE DID NOT COMPLETE THIS COURSE BY PRACTICAL MEANS 
# Although the frontend was also deployed to the same cluster a new task was created for it.
# which resulted in having two urls one for backend and another for the frontend withn the frontend talking to the backend.