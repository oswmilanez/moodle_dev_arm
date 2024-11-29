#OS
FROM debian:12

# Owner
LABEL key="Oswaldo Milanez Neto <oswaldo@milanez.net>"

# Volume
VOLUME /var/www

# Expose Ports
EXPOSE 80 443

# Update and Upgrade
RUN apt-get update && apt-get upgrade -y

# Install Basic
RUN apt-get install -y curl vim htop wget zip unzip

# Install Nginx Server
RUN apt-get install -y nginx

# Install PHP
RUN apt-get install -y \
     php \
     php-common \
     php-curl \
     php-cli \
     php-fpm \
     php-gd \
     php-intl \
     php-mbstring \
     php-mysqlnd \
     php-opcache \
     php-pdo \
     php-igbinary \
     php-imagick \
     php-soap \
     php-xml \
     php-xmlrpc \
     php-zip \ 
     php-ldap \
     php-sqlite3 \
     php-pgsql \
     php-redis \
     php-oauth \
     php-mongodb \
     php-memcache \
     php-memcached \
     php-pear

#composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN ln -s /usr/local/bin/composer /usr/bin/composer

#Configure Nginx
RUN mkdir -p /etc/pki/nginx/private
COPY ./cert/nginx-selfsigned.crt /etc/pki/nginx/nginx-selfsigned.crt
COPY ./cert/nginx-selfsigned.key /etc/pki/nginx/private/nginx-selfsigned.key
COPY ./nginx.conf /etc/nginx/nginx.conf

#Configure PHP
RUN sed -i 's/display_errors\ =\ Off/display_errors\ =\ On/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/;error_log\ =\ syslog/error_log\ =\ \/dev\/stdout/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/memory_limit\ =\ 128M/memory_limit\ =\ 1024M/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/max_execution_time\ =\ 30/max_execution_time\ =\ 300/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/max_input_time\ =\ 60/max_execution_time\ =\ 600/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/upload_max_filesize\ =\ 2/upload_max_filesize\ =\ 1000/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/post_max_size\ =\ 8/post_max_size\ =\ 1000/g' /etc/php/8.2/fpm/php.ini
RUN sed -i 's/;max_input_vars\ =\ 1000/max_input_vars\ =\ 5000/g' /etc/php/8.2/fpm/php.ini

RUN sed -i 's/display_errors\ =\ Off/display_errors\ =\ On/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/;error_log\ =\ syslog/error_log\ =\ \/dev\/stdout/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/memory_limit\ =\ 128M/memory_limit\ =\ 1024M/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/max_execution_time\ =\ 30/max_execution_time\ =\ 300/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/max_input_time\ =\ 60/max_execution_time\ =\ 600/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/upload_max_filesize\ =\ 2/upload_max_filesize\ =\ 1000/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/post_max_size\ =\ 8/post_max_size\ =\ 1000/g' /etc/php/8.2/cli/php.ini
RUN sed -i 's/;max_input_vars\ =\ 1000/max_input_vars\ =\ 5000/g' /etc/php/8.2/cli/php.ini


# Start Container
COPY docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh 
ENTRYPOINT ["./root/docker-entrypoint.sh"]
