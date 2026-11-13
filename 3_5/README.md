# Exercise 3.5 \- Optimized project

## Overview

This repository contains the solution for **Exercise 3.5 \- Optimized project** of [Chapter 4 "Using a non-root user"](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker-fall-2026/chapter-4/using-a-non-root-user) from the *DevOps with Docker (Fall 2026)* course of The University of Helsinki.

The objective of this exercise is to modify the frontend and backend Dockerfiles so that the applications run as **non\-root users** inside their containers while maintaining normal functionality.

Files included:

- Dockerfile.backend
- Dockerfile.frontend

Both Dockerfiles create a dedicated application user and switch to that user before running the application.



## Configuration

### Backend

The backend Dockerfile is configured with:

REQUEST\_ORIGIN=[http://localhost:5001](http://localhost:5001)

This allows requests from the frontend application running on port 5001.

### Frontend

The frontend Dockerfile is configured with:

REACT\_APP\_BACKEND\_URL=[http://localhost:8080](http://localhost:8080)

This allows the frontend application to communicate with the backend service running on port 8080.



## Build Images

From the 3\_5 directory:

```
docker build -t backend-3-5 -f Dockerfile.backend ..

docker build -t frontend-3-5 -f Dockerfile.frontend ..
```

The parent directory ( `..` ) is used as the build context because the application source code resides outside the 3\_5 folder.


## Run Containers

Start the backend container:

```
docker run -p 8080:8080 backend-3-5
```

Start the frontend container:

```
docker run -p 5001:5001 frontend-3-5
```

Application URLs:

- Frontend: [http://localhost:5001](http://localhost:5001)
- Backend: [http://localhost:8080](http://localhost:8080)
- Backend health check: [http://localhost:8080/ping](http://localhost:8080/ping)



## Verification

Backend health check:

```
[http://localhost:8080/ping](http://localhost:8080/ping)
```
Expected response:

```
pong
```

The exercise test script:

```
test_3_05_nonroot_dockerfiles.sh
```

and GitHub Actions workflow both pass successfully.



## Remarks

When opening the frontend application at:

[http://localhost:5001/](http://localhost:5001/)

only the **Exercise 1.14** connectivity check passes successfully.

The remaining frontend checks do not pass in the local environment. However, this does not affect the requirements of **Exercise 3.5**, and the official exercise validation script:

test\_3\_05\_nonroot\_dockerfiles.sh

passes successfully, as does the GitHub Actions pipeline.

Therefore, the solution satisfies the exercise requirements for running both applications as non\-root users.

---
Date : Nov 14 2026