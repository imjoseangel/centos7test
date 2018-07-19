# Ansible Tests with Docker

## Building the Image

### Linux/Unix

`docker build -t centos7test - < Dockerfile`

### Windows

`Get-Content Dockerfile | docker build -t centos7test -`

## Running the Container

`docker run -d -p 2222:22 --name ansible_smoke -v /opt/source:/opt/source -t centos7test`
