FROM phusion/baseimage:0.11

ARG BUILD_DATE
ARG BUILD_VERSION
ARG LMS_DOWNLOAD_URL

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.version=$BUILD_VERSION

ENV DEBCONF_NONINTERACTIVE_SEEN="true" \
	DEBIAN_FRONTEND="noninteractive" \
	DISABLESSH="true" \
	HOME="/root" \
	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8" \
	LANGUAGE="en_US.UTF-8" \
	TERM="xterm"

COPY init /etc/my_init.d/
COPY run /etc/service/logitechmediaserver/

RUN rm -rf /etc/service/cron /etc/service/syslog-ng

RUN	\
	echo "**** Install Dependencies ****" && \
	apt-get update && \
	apt-get -y upgrade -o Dpkg::Options::="--force-confold" && \
	apt-get -y dist-upgrade -o Dpkg::Options::="--force-confold" && \
	apt-get install -y lame faad flac sox perl wget pv make && \
	apt-get install -y libio-socket-ssl-perl libcrypt-ssleay-perl && \
	apt-get install -y openssl libcrypt-openssl-bignum-perl libcrypt-openssl-random-perl libcrypt-openssl-rsa-perl && \
	apt-get install -y mplayer

RUN	\
	echo "**** Install Logitech Media Server package ****" && \
	echo "**** Using source: ${LMS_DOWNLOAD_URL} ****" && \
	latest_lms=${LMS_DOWNLOAD_URL} && \
	mkdir -p /sources && \
	cd /sources && \
	wget --quiet $latest_lms && \
	lms_deb=${latest_lms##*/} && \
	dpkg -i $lms_deb

RUN	chmod -R +x /etc/service/logitechmediaserver /etc/my_init.d/

RUN	\
	echo "**** cleanup ****" && \
	apt-get remove -y locales python-dev && \
	apt-get remove -y wget && \
	apt-get clean -y && \
	apt-get -y autoremove && \
	rm -rf \
		/sources \
		/var/lib/apt/lists/* \
		/tmp/* \
		/var/tmp/*

RUN \
	mkdir /plugins && \
	ln -s /plugins /usr/sbin/Plugins && \
	ln -s /plugins /usr/share/squeezeboxserver/Plugins

VOLUME \
	["/config"]	 	\
	["/music"] 		\
	["/plugins"]	\
	["/playlists"]

EXPOSE 3483 3483/udp 9000 9090

CMD ["/sbin/my_init"]
