# Metro Docker image
# Version 1

# If you loaded redhat-rhel-server-7.0-x86_64 to your local registry, uncomment this FROM line instead:
# FROM registry.access.redhat.com/rhel
# Pull the rhel image from the local registry
FROM registry.access.redhat.com/rhel

MAINTAINER Chris Negus
MAINTAINER MALopez
USER root

# Update image
RUN yum repolist --disablerepo=* && \
    yum-config-manager --disable \* > /dev/null && \
    yum-config-manager --enable rhel-7-server-rpms > /dev/null
# Add httpd package. procps and iproute are only added to investigate the image later.
RUN yum update -y
RUN yum install iproute iputils tcpdump procps-ng wget -y
RUN yum install httpd -y
RUN echo container.metromadrid.net > /etc/hostname

# Create an index.html file
#RUN bash -c 'echo "v2 MetroMadrid Web server test is successful." >> /var/www/html/index.html'
COPY ./index.html /var/www/html/index.html
CMD /usr/sbin/apachectl -D FOREGROUND 
