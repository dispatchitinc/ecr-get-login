<details><summary><b>❗️❗️❗️ Dispatch-specific Notes (expand me) ❗️❗️❗️</b></summary>

We have forked this project in order to make some custom changes to the project and to add a Dockerfile.

### To tag on GitHub

```bash
git tag v1.0.1
git push --tag
```

### To build a new Dockerfile and upload to GitHub packages

```bash
# Set up Go
go mod init ecr-get-login
go mod tidy
go mod vendor
go build

# Build and push docker image
docker build -t ghcr.io/dispatchitinc/ecr-get-login:vX.X.X -f Dockerfile .
docker push ghcr.io/dispatchitinc/ecr-get-login:vX.X.X
```

</details>

ecr-get-login
=============
[![Build Status](https://travis-ci.org/zenreach/ecr-get-login.svg?branch=master)](https://travis-ci.org/zenreach/ecr-get-login)

This is a stand-alone tool for logging in Docker to an ECS Registry. The motivation for this over the AWS CLI tool is to avoid the need to install Python and the various dependencies of the AWS CLI tool.

Usage
-----
The basic usage involves passing an account ID as an argument:

    eval $(ecr-get-login 1234567890)

By default the region will be retrieved from the AWS_REGION environment variable. You may alternatively pass the region via the -region flag:

    eval $(ecr-get-login -region=us-east-1 1234567890)

Example Unit File
-----------------
The following unit file can be used to start ECR prior to a unit which requires ECR access:

    [Unit]
    Description=Log in to ECR
    After=network.target
    [Service]
    Type=oneshot
    User=core
    EnvironmentFile=/etc/environment.ecr
    ExecStart=/usr/bin/sh -c "eval $(/opt/bin/ecr-get-login -region=${ECR_REGION} ${ECR_ACCOUNT})"

The contents of `/etc/environment.ecr` should container the referenced variables:

    ECR_REGION=us-east-1
    ECR_ACCOUNT=1234567890

The above unit file is specific to CoreOS and so runs as the `core` user. This should be changed to a user more appopriate for your OS.
