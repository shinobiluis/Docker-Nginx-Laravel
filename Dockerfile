FROM ubuntu:18.04
LABEL vendor=al3jandro
LABEL version=1.0.0

#actualizacion paquetes y herramientas necesarias
RUN su
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y sudo
RUN sudo ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime
RUN sudo apt-get install -y nano
RUN sudo apt-get install -y vim 

#repositorios, paquetes e instalacion de php y complementos, apache2, git, unzip, npm y ufw
RUN sudo apt-get install -y software-properties-common 
RUN sudo add-apt-repository ppa:ondrej/php && sudo apt-get update
RUN sudo apt-add-repository -y ppa:git-core/ppa && sudo apt-get update
RUN sudo apt-get install -y php7.2
RUN sudo apt-get install -y php7.2-xml
RUN sudo apt-get install -y php7.2-gd
RUN sudo apt-get install -y php7.2-opcache
RUN sudo apt-get install -y php7.2-mysql
RUN sudo apt-get install -y php7.2-zip
RUN sudo apt-get install -y php7.2-soap
RUN sudo apt-get install -y php7.2-sybase
RUN sudo apt-get install -y php7.2-mbstring
RUN sudo apt-get install -y gcc make autoconf libc-dev pkg-config
RUN sudo apt-get install -y php7.2-dev
RUN sudo apt-get install -y libmcrypt-dev
RUN sudo pecl install mcrypt-1.0.1
RUN sudo apt-get install -y nginx
RUN apt-get -y update
RUN sudo apt-get install -y php7.2-fpm
RUN sudo apt-get install -y git 
RUN sudo apt-get install -y unzip
RUN sudo apt-get install -y npm build-essential
RUN sudo apt-get install -y ufw 
RUN sudo apt-get install -y net-tools

#permisos de escritura y ejecucion
RUN sudo chmod -R 777 /var/www
RUN sudo chgrp -R www-data /var/www

#instalando laravel
RUN cd /tmp
RUN curl -sS https://getcomposer.org/installer | php 
RUN sudo mv composer.phar /usr/local/bin/composer
RUN composer --version

#Eliminamos apache
RUN dpkg -l | grep apache2 -y
RUN apt-get purge apache2 apache2-bin apache2-data -y
RUN apt-get autoremove -y
RUN rm -rf  /etc/apache2
RUN rm -rf /var/www/html/index.html

#EXPOSE 80
#enlace simbolico
RUN ln -s /etc/nginx/sites-available/luis /etc/nginx/sites-enabled/luis
RUN ln -s /etc/nginx/sites-available/al3jandro /etc/nginx/sites-enabled/al3jandro
#RUN sudo service php7.2-fpm start
##CMD php7.2-fpm -g 'daemon off;
##CMD nginx -g 'daemon off;'
CMD service php7.2-fpm start && nginx -g "daemon off;"

#CMD service nginx start
#CMD ["nginx", "-g", "daemon off;"]
#CMD ["nginx", "-g", "daemon off;"]
#CMD apachectl -DFOREGROUND
#CMD nginx -g "daemon off;"
#CMD service nginx start
