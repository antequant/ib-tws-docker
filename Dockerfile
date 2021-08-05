# Builder
FROM ubuntu:latest AS builder

RUN apt-get update
RUN apt-get install -y unzip dos2unix wget

WORKDIR /root

RUN wget -q --progress=bar:force:noscroll --show-progress https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh -O install-tws.sh
RUN chmod a+x install-tws.sh

COPY run.sh run.sh
RUN dos2unix run.sh

# Application
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y x11vnc xvfb socat openjfx

WORKDIR /root

COPY --from=builder /root/install-tws.sh install-tws.sh
RUN (echo; echo) | ./install-tws.sh

RUN mkdir .vnc
RUN x11vnc -storepasswd 1358 .vnc/passwd

COPY --from=builder /root/run.sh run.sh

ENV DISPLAY :0
ENV VNC_PORT 5900
EXPOSE $VNC_PORT

CMD ./run.sh
