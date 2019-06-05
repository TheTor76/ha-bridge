FROM ubuntu:18.04

ENV SERVERPORT="80" \
    VERSION="5.2.2" \
    DEBCONF_NONINTERACTIVE_SEEN="true" \
    DEBIAN_FRONTEND="noninteractive"

WORKDIR /]
RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install software-properties-common netcat openjdk-8-jdk wget && \
    usermod -u 99 nobody && \
    usermod -g 100 nobody

RUN apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /ha-bridge-scripts
ADD src/* ./

WORKDIR /config
RUN wget -q -O ./ha-bridge.jar https://github.com/bwssytems/ha-bridge/releases/download/v"$VERSION"/ha-bridge-"$VERSION".jar && \
    mkdir /config/startup-config/

#RUN setcap 'cap_net_bind_service=+ep' /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN chmod -R 0775 /ha-bridge-scripts && \
    chmod -R 0776 /config && \
    chown -R nobody:users /config

USER nobody
VOLUME ["/config/data"]
ENTRYPOINT /ha-bridge-scripts/new_entrypoint
