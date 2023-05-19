FROM ubuntu

RUN mkdir -p /usr/local/bin

COPY ecr-get-login /usr/local/bin/ecr-get-login

RUN chmod 0755 /usr/local/bin/ecr-get-login

RUN apt-get update ; apt-get -y install ca-certificates
