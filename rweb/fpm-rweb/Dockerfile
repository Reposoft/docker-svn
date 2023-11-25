ARG PUSH_TAG=latest
FROM --platform=$TARGETPLATFORM solsson/fpm-svn:$PUSH_TAG

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
    libcurl4 \
    libcurl4-openssl-dev \
    ghostscript \
    graphicsmagick \
    ghostscript \
    locales \
    zlib1g-dev \
    libicu72 \
    libonig5 \
    libonig-dev \
    libzip4 \
    libzip-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN echo "Enable locale(s) for rweb" \
  && sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen \
  && locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "Install php extensions for rweb" \
  && apt-get update \
  && apt-get install -y gcc make libicu-dev g++ \
  && docker-php-ext-install \
    curl \
    mbstring \
    zip \
    intl \
  && apt-get purge -y --auto-remove gcc make libicu-dev g++ \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ADD conf.d/* /usr/local/etc/php/conf.d/
