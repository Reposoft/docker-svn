ARG PUSH_TAG=latest
FROM solsson/rweb-source:$PUSH_TAG as source

ARG PUSH_TAG=latest
FROM --platform=$TARGETPLATFORM solsson/fpm-rweb:$PUSH_TAG

COPY --from=source /opt/rweb /opt/rweb

RUN php /opt/rweb/repos-web/lib/smarty/install.php

ENV REPOS_TEMP=/tmp
