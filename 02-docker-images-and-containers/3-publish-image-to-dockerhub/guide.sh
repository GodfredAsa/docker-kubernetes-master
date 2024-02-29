# There are 2 options
- dockerhub 
- private registry: deals with deployment 
 
# renaming an existing or already created image to match format to be able to push to dockhub registry 
- add tag if the previous name has it 
- newName format => dockerhub_username/newImageName
dcoker tag oldName:tag newName:tag
# Example: docker tag maxmin-app degreatasaa/maxmin-app:v1

# to publish to dockerhub registry 
- login
docker login 
docker push degreatasaa/maxmin-app:v1

# PULLING AND USING SHARED IMAGES 
# when you run docker run imageName before before pulling it will 
# pull the image from dockerhub if you dont have it locally 
# then run it afterwards BUT if you already have the image locally it will run that one but also be careful that when the image is local it will not have the updated version if not pulled.
docker pull dockerhub_username/imageName:tagIfAny
docker run dockerhub_username/imageName:tagIfAny

