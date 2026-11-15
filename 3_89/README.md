# DevOps with Docker, Fall 2026

**University:** University of Helsinki

**Chapter 4:** Optimizing the Image Size

**Exercises:**
- Exercise 3.8 - Multi-stage Frontend
- Exercise 3.9 - Multi-stage Backend

This repository contains the solutions for Exercises 3.8 and 3.9. Both applications are built using multi-stage Docker builds to reduce the final image size and run with non-root users.



# Build and Run

## Build Frontend Image

```bash
docker build -t frontend-3-8 -f Dockerfile.frontend ..
```

## Build Backend Image

```bash
docker build -t backend-3-9 -f Dockerfile.backend ..
```

## Run Backend Container

```bash
docker run -p 8080:8080 backend-3-9
```

## Run Frontend Container

```bash
docker run -p 5001:5001 frontend-3-8
```

## Access the Application

Frontend:

```text
http://localhost:5001
```

Backend API:

```text
http://localhost:8080/ping
```

Expected Backend API response:

```text
pong
```



# Frontend Dockerfile (Exercise 3.8)

The frontend Dockerfile uses a two-stage build.

## Stage 1 - Build Stage

A Node.js image is used to build the React application.

Steps:

1. Copy the frontend source code.
2. Set the backend URL with `REACT_APP_BACKEND_URL`.
3. Install dependencies with `npm install`.
4. Create a production build with `npm run build`.

Output:

```text
React source code
        |
        v
  npm run build
        |
        v
     build/
```

## Stage 2 - Runtime Stage

An unprivileged Nginx image is used to serve the static files.

Steps:

1. Copy the build output from Stage 1.
2. Create a non-root user.
3. Change the Nginx listening port from `8080` to `5001`.
4. Adjust file permissions.
5. Run Nginx as a non-root user.

Benefits:

- Smaller image size
- No Node.js runtime in the final image
- Runs as a non-root user
- Uses Nginx to serve static content

### Note

For Exercise 3.8, the frontend used port `8080`.

For Exercise 3.9, the frontend port was changed to `5001` so that the frontend and backend containers can run on the same host at the same time without port conflicts.



# Backend Dockerfile (Exercise 3.9)

The backend Dockerfile also uses a two-stage build.

## Stage 1 - Build Stage

A Go image is used to compile the application.

Steps:

1. Copy the backend source code.
2. Download Go dependencies.
3. Build the application binary named `server`.
4. Execute unit tests.
5. Create a minimal user definition for the runtime image.

Output:

```text
Go source code
       |
       v
    go build
       |
       v
     server
```

## Stage 2 - Runtime Stage

A minimal `scratch` image is used.

Steps:

1. Copy the compiled `server` binary.
2. Copy the user definition file.
3. Set `REQUEST_ORIGIN=http://localhost:5001`.
4. Run the application as a non-root user.
5. Expose port `8080`.

Benefits:

- Very small runtime image
- No Go compiler in the final image
- Runs as a non-root user
- Only contains the compiled application



# Port Mapping

The application uses the following ports.

```text
Browser
   |
   | http://localhost:5001
   v
+----------------------+
| Frontend (Nginx)     |
| Container Port 5001  |
+----------------------+

Frontend JavaScript
   |
   | HTTP Request
   | http://localhost:8080
   v

+----------------------+
| Backend (Go API)     |
| Container Port 8080  |
+----------------------+
```

## Docker Port Mapping

Frontend:

```bash
docker run -p 5001:5001 frontend-3-8
```

```text
Host Port 5001 --> Container Port 5001
```

Backend:

```bash
docker run -p 8080:8080 backend-3-9
```

```text
Host Port 8080 --> Container Port 8080
```

CORS Configuration:

```text
REQUEST_ORIGIN=http://localhost:5001
```

The backend accepts requests from the frontend running on port 5001.

---

Date : Nov 15 2026