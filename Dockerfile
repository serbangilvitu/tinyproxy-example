FROM docker.io/ubuntu:20.04

ENV ALLOW_LIST="192.168.0.0/16 172.16.0.0/12"

RUN apt-get update && \
  apt-get -y install tinyproxy && \
  chown -R tinyproxy /opt

USER tinyproxy

COPY entrypoint.sh /opt

WORKDIR /opt
ENTRYPOINT [ "/opt/entrypoint.sh" ]