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

RUN apt-get update &&  \
	apt-get install -y nodejs libcrypt-cbc-perl libcrypt-rijndael-perl python3-pip python-pip && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.[^.] ~/.??* ~/*
	
RUN cpanm \
           Crypt::OpenSSL::AES

RUN  pip3 install \
			BroadlinkWifiThermostat cryptography
			
RUN  npm install -g --unsafe-perm --production \
			tradfri-fhem