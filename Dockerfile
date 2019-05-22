FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update -y && apt-get install -yq wget build-essential gcc zlib1g-dev
RUN cd /tmp \
        && wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz \
        && tar zxf Python-3.6.0.tgz \
        && cd Python-3.6.0 \
        && ./configure \
        && make altinstall