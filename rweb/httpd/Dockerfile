ARG PUSH_TAG=latest
FROM --platform=$TARGETPLATFORM solsson/rweb-source:$PUSH_TAG as source

ARG PUSH_TAG=latest
FROM solsson/svn-httpd:$PUSH_TAG

COPY --from=source /opt/rweb /opt/rweb

RUN  sed -i 's|^#LoadModule rewrite_module|LoadModule rewrite_module|' conf/httpd.conf \
  && sed -i 's|^#LoadModule proxy_module|LoadModule proxy_module|' conf/httpd.conf \
  && sed -i 's|^#LoadModule proxy_fcgi_module|LoadModule proxy_fcgi_module|' conf/httpd.conf \
  && cp /opt/rweb/test/conf-svn/rweb-services.conf conf/svn/rweb/services-fpm.conf \
  && echo "Include conf/svn/rweb/*.conf" >> conf/svn/httpd.conf

CMD [ "-DAUTHN=", "-DAUTHZ=", "-DRWEB=fpm" ]
