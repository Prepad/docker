FROM php:8.2-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
    iputils-ping \
    git \
    cron \
    zlib1g-dev \
    libzip-dev \
    procps \
    cron \
    iputils-ping \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    libc-client-dev libkrb5-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install \
    zip \
    pdo \
    pdo_mysql \
    mysqli \
    calendar \
    bcmath \
    exif \
    opcache \
    sockets \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

# Create the log file to be able to run tail
RUN touch /var/log/cron.log
RUN chmod 0755 /var/log/cron.log

RUN printf '* * * * * www-data cd /var/www && /usr/local/bin/php artisan schedule:run\n#' >> /etc/cron.d/hello-cron
RUN crontab /etc/cron.d/hello-cron

RUN echo "memory_limit = 1G" >> /usr/local/etc/php/conf.d/settings.ini

RUN echo "post_max_size = 500M" >> /usr/local/etc/php/conf.d/settings.ini
RUN echo "upload_max_filesize = 500M" >> /usr/local/etc/php/conf.d/settings.ini
RUN echo "output_buffering = 4096" >> /usr/local/etc/php/conf.d/settings.ini
RUN echo "session.sid_length = 26" >> /usr/local/etc/php/conf.d/settings.ini
RUN echo "session.sid_bits_per_character = 5" >> /usr/local/etc/php/conf.d/settings.ini

RUN echo "* soft  nofile  200000" >> /etc/security/limits.conf
RUN echo "* hard  nofile  200000" >> /etc/security/limits.conf
RUN echo "www-data  soft  nofile 200000" >> /etc/security/limits.conf
RUN echo "www-data  hard  nofile 200000" >> /etc/security/limits.conf
RUN echo "root soft nofile 200000" >> /etc/security/limits.conf
RUN echo "root hard nofile 200000" >> /etc/security/limits.conf
RUN echo "nginx soft nofile 200000" >> /etc/security/limits.conf
RUN echo "nginx hard nofile 200000" >> /etc/security/limits.conf

RUN echo "fs.file-max = 200000" >> /etc/sysctl.conf

EXPOSE 9000

WORKDIR /var/www/
