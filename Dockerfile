FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY :0

ENV USERNAME developer

WORKDIR /app

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-transport-https sudo \
    software-properties-common \
    dirmngr gnupg

RUN add-apt-repository ppa:xtradeb/apps -y

RUN apt update

RUN apt install -y avidemux-qt avidemux-cli

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo

USER $USERNAME

WORKDIR /home/$USERNAME

CMD avidemux3_qt5