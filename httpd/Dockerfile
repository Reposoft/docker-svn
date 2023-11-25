
FROM --platform=$TARGETPLATFORM httpd:2.4.58-bookworm@sha256:04551bc91cc03314eaab20d23609339aebe2ae694fc2e337d0afad429ec22c5a

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
		libpcre3-dev \
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
	&& apt-get purge -y --auto-remove $depsBuild \
	&& rm -r /var/lib/apt/lists/* \
	&& echo "Include conf/svn/httpd.conf" >> conf/httpd.conf

COPY conf conf/svn

# TODO is there a licensing aspect on copy from project source instead of downloading from docker build?
COPY site_perl /usr/local/lib/site_perl
COPY bin/* admin-cgi/
RUN ln -s $(pwd)/admin-cgi/repocreate /usr/local/bin/repocreate

# Set to non-empty to enable /admin/repocreate http endpoint
ENV ADMIN_REST_ACCESS ""

# httpd config has hard coded /svn for parent path, but if we declare a Volume here you can't prepare repositories in downstream images
#VOLUME /svn

RUN mkdir /svn && chown daemon /svn

# Env requires wrapper entrypoint, which we abandoned in https://github.com/solsson/docker-library-httpd/tree/stretch
# Set to "anon" to pick up username (for commit log etc) from BASIC auth header without verification of credentials
#ENV AUTHN ""
# Set to "svn"/"inrepo"/"admrepo", see conf/authz/options.conf
#ENV AUTHZ ""
# Set to "fpm" to enable rweb conf
#ENV RWEB ""

ENTRYPOINT ["httpd-foreground"]
CMD [ "-DAUTHN=", "-DAUTHZ=", "-DRWEB=" ]
