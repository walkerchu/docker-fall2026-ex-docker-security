#!/bin/sh
set -e  # exits immediately if any command fails

# DevOps with Docker, Fall 2026
# offer by The University of Helsinki
# chapter 4/deployment-pipelines
# url: https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker-fall-2026/chapter-4/deployment-pipelines
# Exercise 3.4. Building images from inside a container
# created at Nov 07, 2026 17:00 HKT

temp_path=$PWD/temp 

cleanup() {
  rm -rf "$temp_path"

  if [ ! -d "$temp_path" ]; then
    echo "Remove successful. Temporary folder does not exist."
  else
    echo "Remove temporary folder is not successful."
  fi
}

if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <docker-image>"
  exit 1
fi


if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
    echo "found DOCKER_USER / DOCKER_PWD. Execute 'docker login' ...."
    docker login \
      --username "$DOCKER_USER" \
      --password "$DOCKER_PWD"
fi

repo="https://github.com/$1"
image=$2

echo
echo "GitHub repo:  $repo"
echo "Docker image: $image"
echo

# Registers cleanup() to be called on script exit
trap cleanup EXIT

echo "Start to git clone $repo ......."
git clone $repo "$temp_path"
echo

cd "$temp_path"

docker build -t "$image" .  # build image
echo
docker image ls $image  # list image to confirm successful
echo
docker push "$image"  # push image to Docker Hub
echo


