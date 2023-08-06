#!/bin/bash
echo 'Switching dockerhub account'
rm ~/.docker/config.json && cp ~/.docker/config.json.awslabca ~/.docker/config.json

echo 'Stopping awscli container...'
docker stop awscli
echo 'Removing awscli container image...'
docker rmi -f awslabca/aws-cli-env

echo 'Removing all unused data...'
docker system prune -f
docker buildx prune -f

docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx build --platform linux/arm64,linux/amd64 -t awslabca/aws-cli-env:latest -t awslabca/aws-cli-env:`date "+%Y%m%d"`.1 . --push
docker run -it --rm --name awscli -d awslabca/aws-cli-env:latest

docker buildx prune -f
