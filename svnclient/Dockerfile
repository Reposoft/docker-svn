FROM --platform=$TARGETPLATFORM debian:bullseye-slim@sha256:4c25ffa6ef572cf0d57da8c634769a08ae94529f7de5be5587ec8ce7b9b50f9c

ENV SVN_VERSION 1.14.1
ENV SVN_BZ2_URL https://archive.apache.org/dist/subversion/subversion-$SVN_VERSION.tar.bz2
ENV SVN_BZ2_SHA513 0a70c7152b77cdbcb810a029263e4b3240b6ef41d1c19714e793594088d3cca758d40dfbc05622a806b06463becb73207df249393924ce591026b749b875fcdd

RUN depsRuntime=' \
		libsqlite3-0 \
		ca-certificates \
		curl \
		jq \
		libapr1 \
		libaprutil1 \
		libneon27 \
		libserf-1-1 \
	' \
	&& depsBuild=' \
		bzip2 \
		gcc \
		libpcre++-dev \
		libssl-dev \
		make \
		libsqlite3-dev \
		libz-dev \
		libapr1-dev \
		libaprutil1-dev \
		libneon27-dev \
		libserf-dev \
	' \
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
	&& make -j"$(nproc)" \
	&& make install \
	&& /sbin/ldconfig \
	&& cd ../../ \
	&& rm -r src/svn \
	&& apt-get purge -y --auto-remove $depsBuild
