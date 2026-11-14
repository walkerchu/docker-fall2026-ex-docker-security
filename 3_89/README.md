# Exercise 3.8 \- Multi\-stage Build

This exercise demonstrates how to optimize a frontend container image using a multi\-stage Docker build.

## Frontend Dockerfile (Exercise 3.8)

The frontend Dockerfile is divided into two stages:

### Stage 1 \- Build Stage

A Node.js image is used to build the React application.

Steps:

1. Copy the frontend source code into the container.
2. Install project dependencies using npm install.
3. Generate the production build using npm run build.

The output of this stage is a static website stored in the build/ directory.

### Stage 2 \- Runtime Stage

A lightweight Nginx image is used to serve the static files generated in Stage 1.

Steps:

1. Copy the contents of the build/ directory from the previous stage.
2. Configure file ownership for a non\-root user.
3. Run Nginx as a non\-root user.
4. Expose port 8080 for incoming HTTP requests.

### Benefits of Multi\-stage Builds

- Smaller final image size.
- Build tools such as Node.js and npm are excluded from the runtime image.
- Improved security by running the container as a non\-root user.
- Faster image download and deployment.

### Build and Run

Build the image:

```
docker build -t frontend-3-8 -f Dockerfile.frontend ..
```

Run the container:

```
docker run -p 8080:8080 frontend-3-8
```

Open the application in your browser:

```
http://localhost:8080
```


## Backend Dockerfile (Exercise 3.9)

*To be completed in Exercise 3.9.*

---
last modified : Nov 14 2026