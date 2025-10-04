![Docker Desktop to ACR](./Assets/docker_desktop_to_acr.png)

## Build the Docker Image and Run the Container Locally

The Dockerfile is a set of instructions that tells Docker how to build the container image. The FROM instruction specifies the base image to use. The ENV instruction sets an environment variable, and the EXPOSE instruction tells Docker which port the application will listen on.

### Build the Docker Image

To build the Docker image, run the following command in the terminal (make sure the terminal is open in the same directory as the Dockerfile which in this case is /redish-app directory in the lab2_deploying_AI_app folder):

```bash
docker build -t redish-app:latest .
```

With the container image built, we can now run it locally.
```bash
docker run -p 80:80 redish-app:latest
```

## Push the container image to a container registry

Now that the application containerized and confirmed to be running locally, we can push it to a container registry. In this case, we will use Azure Container Registry (ACR).

Run the following commands to get the name of the ACR and login.
```bash
az acr login --name $ACR_NAME
```

(elsewhere do
Use `az acr login -n demoaksregistry --expose-token`
- This command will generate here refresh token value with the username
- Then manual using docker login command
`docker login demoaksregistry.azurecr.io `
With username: <your_username>
And password: <refreshToken>'`
)
Make sure to replace `$ACR_NAME` with the name of your Azure Container Registry.

Run the following command to tag the container image with the ACR registry name.
```bash
docker tag redish-app:latest $ACR_NAME.azurecr.io/redish-app:latest
```

Now that the image is tagged, we can push it to ACR.
```bash
docker push $ACR_NAME.azurecr.io/redish-app:latest
```


