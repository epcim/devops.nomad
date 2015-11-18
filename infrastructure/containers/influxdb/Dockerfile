FROM centos:7
MAINTAINER Xavier Bruhiere <xavier.bruhiere@gmail.com>

ENV INFLUXDB_VERSION 0.9.5-rc3_x86_64

RUN curl -s -o /tmp/influxdb.rpm https://s3.amazonaws.com/influxdb/influxdb-${INFLUXDB_VERSION}.rpm && \
  yum localinstall -y /tmp/influxdb.rpm && \
  rm -f /tmp/influxdb.rpm

# Admin server WebUI
EXPOSE 8083

# HTTP API
EXPOSE 8086

# Raft port (for clustering, don't expose publicly!)
#EXPOSE 8090

# Protobuf port (for clustering, don't expose publicly!)
#EXPOSE 8099

VOLUME ["/data"]

CMD ["influxd"]
