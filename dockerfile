FROM openjdk:8-bullseye
RUN \
  apt-get update \
  && apt-get -y install gettext-base \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

#valid values: zookeeper|server
ENV KAFKA_RUN_AS="server"

ENV KAFKA_VERSION="2.13-3.1.0"
ENV KAFKA_HOME="/opt/kafka"
ENV BASE_DIR="/entrypoint/"

RUN mkdir -p $KAFKA_HOME
COPY ./kafka_$KAFKA_VERSION/ $KAFKA_HOME

COPY *.sh $BASE_DIR

WORKDIR $KAFKA_HOME/bin
EXPOSE 2181
#ENTRYPOINT bash /$BASE_DIR/run_infinity.sh
#ENTRYPOINT bash kafka-server-start.sh ../config/server.properties
ENTRYPOINT bash /$BASE_DIR/run.sh