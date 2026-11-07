#!/bin/sh
set -e  # exits immediately if any command fails

# DevOps with Docker, Fall 2026
# offer by The University of Helsinki
# chapter 4/deployment-pipelines
# url: https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker-fall-2026/chapter-4/deployment-pipelines
# Exercise 3.3. Scripting magic
# created at Nov 07, 2026 14:10 HKT

if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <docker-image>"
  exit 1
fi

# remove git clone target directory if it exists
# (avoids failure when rerunning the script)
repo_dir="${1#*/}"
if [ -d "$repo_dir" ]; then
  echo "removing $repo_dir ....." 
  rm -rf $repo_dir
fi
echo

repo="https://github.com/$1"
image=$2

echo "GitHub repo:  $repo"
echo "Docker image: $image"
echo
echo "Start to git clone $repo ......."
git clone $repo
echo

cd "$repo_dir" || exit 1
docker build -t "$image" .  # build image
echo
docker image ls $image  # list image to confirm successful
echo
docker push "$image"  # push image to Docker Hub
echo
docker search $image --limit 1  #search image to confirm successful