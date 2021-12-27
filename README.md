# Multi-Stage-Build

Multi-stage Docker builds let you write Dockerfiles with multiple FROM statements. This means you can create images which derive from several bases, which 
can help cut the size of your final build. i.e. Multistage builds feature in Dockerfiles enables you to create smaller container images with better caching 
and smaller security footprint.

## Requirements

- [Install Docker](https://docs.docker.com/engine/install/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

## Building a Docker Image

1. Generate a Dockerfile inorder to build a docker image. Always keep in mind that this file should be placed inside a specific folder. 

 $ vim Dockerfile

 ```
 FROM alpine:3.8 As github

 RUN mkdir /var/flaskapp

 WORKDIR   /var/flaskapp

 RUN apk update && apk add --no-cache git

 RUN git clone https://github.com/Swathikarun/docker-python-flask.git .


 FROM alpine:3.8

 RUN mkdir /var/flaskapp

 WORKDIR   /var/flaskapp

 COPY --from=github /var/flaskapp/* ./

 RUN apk update && apk add --no-cache python3

 RUN pip3 install -r requirements.txt

 EXPOSE 5000

 CMD ["/usr/bin/python3" , "app.py"]
 ```

2. Create a docker image

```
 $ docker build -t swathikarun/flaskapp:v1 .
```
3. List the image

```
$ docker image ls
```
 
## Create a container using this image

```
 $ docker container run --name app -d -p 80:5000 swathikarun/flaskapp:v1
```
