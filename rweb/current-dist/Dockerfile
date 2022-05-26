FROM debian:bullseye-slim@sha256:fbaacd55d14bd0ae0c0441c2347217da77ad83c517054623357d1f9d07f79f5e

ENV RWEB_VERSION=1.8.0
ENV RWEB_TGZ_URL=https://github.com/Reposoft/rweb/releases/download/v${RWEB_VERSION}/ReposWeb-${RWEB_VERSION}.tgz
ENV RWEB_TGZ_SHA256=f35e530df84193dd867f55c0c3e2f1d6dadf04b994256196ff44657dbcefd063

ADD $RWEB_TGZ_URL /usr/src/rweb-$RWEB_VERSION.tar.gz

RUN echo "$RWEB_TGZ_SHA256 /usr/src/rweb-$RWEB_VERSION.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/src/rweb \
  && tar -xvf /usr/src/rweb-$RWEB_VERSION.tar.gz -C /usr/src/rweb \
  && rm /usr/src/rweb-$RWEB_VERSION.tar.gz \
  && mkdir /opt/rweb \
  && mv /usr/src/rweb/repos-web /opt/rweb/ \
  && mv /usr/src/rweb/repos-plugins /opt/rweb/

ADD https://github.com/Reposoft/rweb/raw/v${RWEB_VERSION}/test/conf-svn/rweb-services.conf /opt/rweb/test/conf-svn/rweb-services.conf

FROM scratch

COPY --from=0 /opt/rweb /opt/rweb
