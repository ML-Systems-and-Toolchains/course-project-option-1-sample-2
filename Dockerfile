FROM ubuntu:latest

# Install PostgreSQL
USER root
SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace/

RUN apt-get update && \
    apt-get install -y --force-yes \
    software-properties-common \
    wget \
    sudo \
    postgresql \
    postgresql-contrib \
    python3-pip \
    nano \
    openjdk-11-jdk && \
    apt-get clean

ADD ./requirements.txt /workspace/requirements.txt
RUN pip3 install -r requirements.txt

RUN wget 'https://jdbc.postgresql.org/download/postgresql-42.5.0.jar' && \
    mv /workspace/postgresql-42.5.0.jar /usr/local/lib/python3.10/dist-packages/pyspark/jars/

RUN service postgresql start

CMD tail -f /dev/null
