FROM debian:bullseye-slim@sha256:fbaacd55d14bd0ae0c0441c2347217da77ad83c517054623357d1f9d07f79f5e

ENV RWEB_VERSION=1.7.14
ENV RWEB_TGZ_URL=https://github.com/Reposoft/rweb/releases/download/$RWEB_VERSION/ReposWeb-$RWEB_VERSION.tgz
ENV RWEB_TGZ_SHA256=5dd32f2caa7cc23b1cd775329c7f82e04a81ab20b8b22dcaed95cb032cbd947b

ADD $RWEB_TGZ_URL /usr/src/rweb-$RWEB_VERSION.tar.gz

RUN echo "$RWEB_TGZ_SHA256 /usr/src/rweb-$RWEB_VERSION.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/src/rweb \
  && tar -xvf /usr/src/rweb-$RWEB_VERSION.tar.gz -C /usr/src/rweb \
  && rm /usr/src/rweb-$RWEB_VERSION.tar.gz \
  && mkdir /opt/rweb \
  && mv /usr/src/rweb/repos-web /opt/rweb/ \
  && mv /usr/src/rweb/repos-plugins /opt/rweb/

FROM scratch

COPY --from=0 /opt/rweb /opt/rweb
