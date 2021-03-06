####
# This Dockerfile is used in order to build a container that runs the Quarkus application in JVM mode
#
# Before building the docker image run:
#
# mvn package
#
# Then, build the image with:
#
# docker build -f src/main/docker/Dockerfile.jvm -t quarkus/getting-started-jvm .
#
# Then run the container using:
#
# docker run -i --rm -p 8080:8080 quarkus/getting-started-jvm
#
###

FROM fhem/fhem
LABEL org.opencontainers.image.source https://github.com/comdata/fhem

RUN apt-get update &&  \
	apt-get install -y nodejs libcrypt-cbc-perl libcrypt-rijndael-perl python3-pip python-pip && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.[^.] ~/.??* ~/*
	
RUN cpanm \
           Crypt::OpenSSL::AES

RUN  apt-get update && \
	 apt-get install -qqy --no-install-recommends \
          libinline-python-perl \
          python3 \
          python3-dev \
          python3-pip \
          python3-setuptools \
          python3-wheel \
		  build-essential libssl-dev libffi-dev python-dev  && \
 	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.[^.] ~/.??* ~/*
#	&& \
RUN	pip3 install \
			BroadlinkWifiThermostat cryptography simplejson paho-mqtt \
	&&  \
	mkdir /opt/BroadLink && \	
#	chown fhem.dialout /opt/BroadLink && \
	cd /opt/BroadLink && \
	git clone https://github.com/mjg59/python-broadlink.git && \
	cd python-broadlink && \
	python setup.py install && \ 
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.[^.] ~/.??* ~/*
	

			
RUN  npm install -g --unsafe-perm --production \
			tradfri-fhem