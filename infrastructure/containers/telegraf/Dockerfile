FROM centos:7
MAINTAINER Xavier Bruhiere <xavier.bruhiere@gmail.com>

ENV TELEGRAF_VERSION 0.2.1-1.x86_64

RUN curl -s -o /tmp/telegraf.rpm http://get.influxdb.org/telegraf/telegraf-${TELEGRAF_VERSION}.rpm && \
  yum localinstall -y /tmp/telegraf.rpm && \
  rm -f /tmp/telegraf.rpm

# overwrite standard location
ADD ./config.toml /etc/opt/telegraf/telegraf.conf
ADD run.sh /run.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]
