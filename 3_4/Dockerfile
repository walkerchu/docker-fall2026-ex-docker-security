# DevOps with Docker, Fall 2026
# offer by The University of Helsinki
# chapter 4/deployment-pipelines
# url: https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker-fall-2026/chapter-4/deployment-pipelines
# Exercise 3.4. Building images from inside a container
# created at Nov 08, 2026 03:55 HKT

FROM docker:29.9.3-cli-alpine3.24

WORKDIR /app

COPY builder.sh /app

ENTRYPOINT ["/app/builder.sh"]