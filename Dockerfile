FROM ubuntu:20.04

# Set timezone 'Europe/Brussels'
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ 'Europe/Brussels'
RUN echo $TZ > /etc/timezone && \
  apt-get update && apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

RUN apt-get -y update

RUN apt-get install -y build-essential sudo
RUN apt-get install -y git wget curl rsync bc apt-transport-https libxml2 libxml2-dev libcurl4-openssl-dev
RUN apt-get install -y gawk libreadline6-dev libyaml-dev autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
RUN apt-get install -y libmagickwand-dev imagemagick inkscape
RUN apt-get install -y nodejs vim qt5-default libqt5webkit5-dev xvfb dbus-x11 gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xfonts-base xfonts-75dpi
RUN apt-get install -y unzip netcat libgconf-2-4 poppler-utils


RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 3A79BD29
RUN echo 'deb http://repo.mysql.com/apt/ubuntu/ bionic mysql-5.7' > /etc/apt/sources.list.d/mysql.list
ADD mysql /etc/apt/preferences.d/mysql

RUN apt-get remove -y mysql-client mysql-common mysql-server libmysqlclient-dev
RUN apt-get purge -y mysql-client mysql-common mysql-server libmysqlclient-dev
RUN apt-get -y update
RUN apt-get install -y mysql-client libmysqlclient-dev


RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.focal_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.focal_amd64.deb

RUN git clone https://github.com/rbenv/ruby-build.git && \
  PREFIX=/usr/local ./ruby-build/install.sh && \
  ruby-build -v 2.1.10 /usr/local
