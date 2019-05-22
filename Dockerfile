FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update -y

# Python
RUN cd /tmp \
        && wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz \
        && tar zxf Python-3.6.0.tgz \
        && cd Python-3.6.0 \
        && ./configure \
        && make altinstall \
        && echo alias python="python3.6" >> ~/.bash_profile

# # Standard packages
# RUN pip install numpy scipy pandas matplotlib jupyter
# RUN flask

# OpenCV
# RUN apt-get install -yq wget build-essential gcc zlib1g-dev libtbb2 libtbb-dev \
#     libjpeg-dev libjasper-dev libdc1394-22-dev \
#     python-opencv libopencv-dev libav-tools python-pycurl \
#     libatlas-base-dev gfortran webp qt5-default libvtk6-dev zlib1g-dev

# # OpenCV
# RUN apt-get install -y cmake libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
# RUN git clone https://github.com/Itseez/opencv.git \
#     && git clone https://github.com/Itseez/opencv_contrib.git \
#     && cd opencv && mkdir build && cd build && cmake  -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON .. \
#     && make -j4 && make install && ldconfig && rm -rf ~/opencv*  # Remove the opencv folders to reduce image size \
#     && ln /dev/null /dev/raw1394