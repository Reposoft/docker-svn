FROM solsson/fpm-rweb

ENV RWEB_VERSION=1.7.14
ENV RWEB_TGZ_URL=https://github.com/Reposoft/rweb/releases/download/$RWEB_VERSION/ReposWeb-$RWEB_VERSION.tgz
ENV RWEB_TGZ_SHA256=5dd32f2caa7cc23b1cd775329c7f82e04a81ab20b8b22dcaed95cb032cbd947b

RUN echo "Downloading rweb source..." \
  && curl -SLk "$RWEB_TGZ_URL" -o /usr/src/rweb-$RWEB_VERSION.tar.gz \
  && echo "$RWEB_TGZ_SHA256 /usr/src/rweb-$RWEB_VERSION.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/src/rweb \
  && tar -xf /usr/src/rweb-$RWEB_VERSION.tar.gz -C /usr/src/rweb \
  && rm /usr/src/rweb-$RWEB_VERSION.tar.gz \
  && mkdir /opt/rweb \
  && mv /usr/src/rweb/repos-web /opt/rweb/ \
  && mv /usr/src/rweb/repos-plugins /opt/rweb/

RUN php /opt/rweb/repos-web/lib/smarty/install.php

ENV REPOS_TEMP=/tmp
