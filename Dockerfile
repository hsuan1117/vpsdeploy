FROM ubuntu:18.04

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata apt-utils &&\
    apt-get install -y openssh-server tmux nano wget curl vim sudo apache2 php && \
    apt-get install libapache2-mod-php 
RUN mkdir /var/run/sshd
RUN echo 'root:vpsdeploy_r00t_passw0rd' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 80 443 8080 10022
CMD    ["/usr/sbin/sshd", "-D"]
CMD apachectl -D FOREGROUND
