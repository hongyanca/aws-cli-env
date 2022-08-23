# AWS Command Line Interface (AWS CLI) Container Image



This image is built from https://hub.docker.com/_/amazonlinux. It includes aws cli, util-linux, unzip, zsh, and nano. There are 3 pre-created users: alice, bob, and charlie. These users can be used to test AWS cross-account access using different profiles.

## Build the image

```docker build -t aws-cli-env .```

## Run and access the container

```shell
docker run -it --rm --name awscli -d aws-cli-env
docker exec -it --user root awscli /usr/bin/zsh
```

## Copy credentials from host to the container

```shell
docker cp [CREDENTIALS] awscli:/root/.aws/

docker cp [CREDENTIALS] awscli:/home/alice/.aws/
docker exec -it awscli chown alice:alice /home/alice/.aws/credentials
```

## Delete credentials from the container

```shell
docker exec -it awscli rm -rf /root/.aws/credentials
docker exec -it awscli rm -rf /home/alice/.aws/credentials
docker exec -it awscli rm -rf /home/bob/.aws/credentials
docker exec -it awscli rm -rf /home/charlie/.aws/credentials
```

