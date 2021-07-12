FROM python:3.9.6
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y vim less
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# OpenCVをPythonで動かそうとしてlibGL.soが無いって言われたけど解決した。
# https://qiita.com/toshitanian/items/5da24c0c0bd473d514c8
RUN apt-get install -y libgl1-mesa-dev
RUN apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6

#
# https://hub.docker.com/r/ultralytics/yolov5
#

#RUN git clone https://github.com/ultralytics/yolov5
RUN git clone https://github.com/yamahei/yolov5.git
RUN cd yolov5
run wget https://raw.githubusercontent.com/yamahei/yolov5/master/requirements.txt
RUN pip install -r requirements.txt

# --

RUN cd
COPY python3/sample.py /root/sample.py

# --------------------
# How to build and run
# --------------------
# $ #docker system prune
# $ docker-compose up --build
# $ docker-compose exec python3 bash
# root@python3# python sample.py
# Using cache found in /root/.cache/torch/hub/ultralytics_yolov5_master
# YOLOv5 � 2021-7-12 torch 1.9.0+cu102 CPU
# 
# Fusing layers...
# /usr/local/lib/python3.9/site-packages/torch/nn/functional.py:718: UserWarning:Named tensors and all their associated APIs are an experimental feature and subject to change. Please do not use them for anything important until they are released as stable. (Triggered internally at  /pytorch/c10/core/TensorImpl.h:1156.)
#   return torch.max_pool2d(input, kernel_size, stride, padding, dilation, ceil_mode)
# Model Summary: 224 layers, 7266973 parameters, 0 gradients
# Adding AutoShape...
# image 1/1: 720x1280 2 persons, 2 ties
# Speed: 431.4ms pre-process, 80.8ms inference, 1.2ms NMS per image at shape (1, 3, 384, 640)
