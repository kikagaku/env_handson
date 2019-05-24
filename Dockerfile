FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update -y
RUN apt-get install -y wget build-essential gcc zlib1g-dev libssl-dev

# Python
RUN apt-get install -y python3-pip python3-dev git libhdf5-dev

RUN ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip

# Standard packages
RUN pip install -U pip
RUN pip install numpy scipy sklearn pandas matplotlib seaborn flask jupyter

# OpenCV
RUN apt-get install -y libopencv-dev
RUN pip install opencv-python
RUN pip install opencv-contrib-python

# MeCab
RUN cd /tmp \
    && wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -O mecab.tar.gz \
    && tar zxvf mecab.tar.gz \
    && cd mecab-0.996 \
    && ./configure \
    && make \
    && make install
RUN pip install mecab-python3
RUN apt-get update
RUN apt-get install -y curl sudo
RUN cd /tmp \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && cd mecab-ipadic-neologd \
    && ./bin/install-mecab-ipadic-neologd -n -y
COPY mecabrc /usr/local/etc/mecabrc
RUN cat /usr/local/etc/mecabrc
RUN echo 'export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"' >> ~/.bash_profile

# Jupyter Notebook
RUN apt-get install -y vim
RUN jupyter notebook --generate-config
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN mkdir /work
ENTRYPOINT cd /work && jupyter notebook