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
