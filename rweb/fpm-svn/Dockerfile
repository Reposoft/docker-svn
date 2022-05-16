FROM php:8.1.6-fpm-bullseye@sha256:0cb64efb1f36d9945d10c519d9c67662b05c45707ca961331481969be0ab6fc9

# Same build concept as in httpd,
# but rweb should only have the svn client with http ra

ENV SVN_VERSION 1.14.2
ENV SVN_BZ2_URL https://archive.apache.org/dist/subversion/subversion-$SVN_VERSION.tar.bz2
ENV SVN_BZ2_SHA512 20ada4688ca07d9fb8da4b7d53b5084568652a3b9418c65e688886bae950a16a3ff37710fcfc9c29ef14a89e75b2ceec4e9cf35d5876a7896ebc2b512cfb9ecc

ENV DEBIAN_FRONTEND noninteractive

RUN depsRuntime=" \
		libsqlite3-0 \
		curl \
		ca-certificates \
		libserf-1-1 \
		liblz4-1 \
		libutf8proc2 \
	" \
	&& depsBuild=" \
		ca-certificates \
		bzip2 \
		gcc \
		libpcre++-dev \
		libssl-dev \
		make \
		libsqlite3-dev \
		zlib1g-dev \
		libneon27-dev \
		libserf-dev \
		liblz4-dev \
		libutf8proc-dev \
	" \
	set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $depsRuntime \
	&& apt-get install -y --no-install-recommends $depsBuild \
  && rm -r /var/lib/apt/lists/* \
  && curl -SL "$SVN_BZ2_URL" -o subversion-$SVN_VERSION.tar.bz2 \
  && echo "$SVN_BZ2_SHA512 subversion-$SVN_VERSION.tar.bz2" | sha512sum -c - \
  && mkdir -p src/svn \
  && tar -xvf subversion-$SVN_VERSION.tar.bz2 -C src/svn --strip-components=1 \
  && rm subversion-$SVN_VERSION.tar.bz2* \
  && cd src/svn \
  && ./configure \
    --with-serf \
    --without-gpg-agent \
    --without-berkeley-db \
    --without-apxs \
    --without-swig \
  && make -j"$(nproc)" \
  && make install \
  && cd ../../ \
  && rm -r src/svn \
  && apt-get purge -y --auto-remove $buildDeps
