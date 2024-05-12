# Base Image
FROM ubuntu:latest

# Base Image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y apache2 wget unzip

# change directory
RUN cd /var/www/html

# download webfiles
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page296/neogym.zip

# unzip folder
RUN unzip neogym.zip

# copy files into html directory
RUN cp -rvf neogym-html/* /var/www/html

# remove unwanted folders
## RUN rm -rf photogenic photogenic.zip

# Start apache2 service
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN service apache2 restart

# expose port 80 on the container
EXPOSE 80

# command to start when to docker start
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]