# DOCKER CORE CONCEPTS
  # CONTAINERS 
    - isolated boxes containing our code and the environment to run the code.
    - they are single focused, which means we dont do multiple things in a single container.
    - Example run db in a container, webserver in another container 
    - shareable and reproducible
    - stateless (+ volumes)
    - created from images from dockerhub or custom images using a Dockerfile 

  # IMAGES  
    - we can one or multiple containers on the same image. 
    - act as blueprint for containers 
    - contains code and environment, are read-only and does not run.
    - can be built and shared with others.
    - created with instructions (layers)


# DOCKER LOCAL HOST MACHINE (DEVELOPMENT)


# DOCKER REMOTE HOST (DEVELOPMENT / PRODUCTION )