FROM debian:bookworm-slim@sha256:2bc5c236e9b262645a323e9088dfa3bb1ecb16cc75811daf40a23a824d665be9

ENV RWEB_VERSION=1.8.6
ENV RWEB_TGZ_URL=https://github.com/Reposoft/rweb/releases/download/v${RWEB_VERSION}/ReposWeb-${RWEB_VERSION}.tgz
ENV RWEB_TGZ_SHA256=b142c005f0d669ea2f531f4fb43311bd0bfabf1540980ee1bfb93d78e31d2b32

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
