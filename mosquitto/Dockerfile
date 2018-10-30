# Modified from eclipse-mosquitto dockerfile:
# https://github.com/eclipse/mosquitto/blob/0bb602ed7a89da80d25e6b959a130fdcf0556be5/docker/1.4.12/Dockerfile

FROM alpine:latest
# any reason to use specific version? should I use alpine:latest??
MAINTAINER Aephir <aephirone@gmail.com>

LABEL Description="Eclipse Mosquitto MQTT Broker and clients"

# It originally had 'add mosquitto=1.4.12-r0';
RUN apk --no-cache add mosquitto && \
    apk --no-cache add mosquitto-clients && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config/mosquitto.conf && \
    chown -R mosquitto:mosquitto /mosquitto

COPY docker-entrypoint.sh /
# ENTRYPOINT ["/docker-entrypoint.sh"]
ENTRYPOINT ["mosquitto", "/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]


#######################
# This is what Ludeeus said on 20180926 @11.54 - https://discordapp.com/channels/330944238910963714/449717345808547842
#docker exec -it MQTT sh
#apk update
#apk add mosquitto-clients
