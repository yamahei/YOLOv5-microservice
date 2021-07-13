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
RUN wget https://raw.githubusercontent.com/yamahei/yolov5/master/requirements.txt
RUN pip install -r requirements.txt

# --
RUN pip install flask


RUN cd
COPY python3/microservice.py /root/microservice.py

# --------------------
# How to build and run
# --------------------
# $ #docker system prune
# $ docker-compose up --build
# $ curl -X POST -F file=@sampleimage.jpg http://localhost:8010/detection
