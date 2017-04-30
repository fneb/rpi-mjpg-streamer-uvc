FROM tukiyo3/rpi-ja
MAINTAINER Fneb <bethany@bethanycorcoran.co.uk>
RUN apt-get update
RUN apt-get install -y apt-utils curl wget unzip libjpeg8-dev make gcc cmake g++ git
RUN ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h
RUN cd ~ && git clone https://github.com/jacksonliam/mjpg-streamer
RUN apt-get upgrade -y
RUN cd ~/mjpg-streamer/mjpg-streamer-experimental && make && make install
CMD LD_LIBRARY_PATH=/root/mjpg-streamer/mjpg-streamer-experimental /root/mjpg-streamer/mjpg-streamer-experimental/mjpg_streamer -i "input_uvc.so -d /dev/video0 -r 1920x1080 -f 30" -o "output_http.so -w /root/mjpg-streamer-master/mjpg-streamer-experimental/www -p 8080"
