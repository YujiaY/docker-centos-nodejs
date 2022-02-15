FROM centos:8

# FROM centos:7

MAINTAINER JackY (aujackyuan@gmail.com)

RUN cd /etc/yum.repos.d/

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*

RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN (curl -sL https://rpm.nodesource.com/setup_14.x | bash -)
run yum clean all -y
RUN yum update -y
RUN yum install -y nodejs
RUN yum autoremove -y
RUN yum clean all -y
RUN npm install npm --global

RUN node -v

run npm -v
# Copy app to /src
COPY . /src

# Install app and dependencies into /src
RUN cd /src; npm install

EXPOSE 8080

CMD cd /src && node ./app.js
