#! /bin/sh

CONFIG_FILE=/etc/opt/telegraf/telegraf.conf
INFLUX_USER=${INFLUX_USER:-"root"}
INFLUX_PASS=${INFLUX_PASS:-"root"}
INFLUX_DB=${INFLUX_DB:-"telegraf"}
INFLUX_HOST=${INFLUX_HOST:-"localhost"}
INFLUX_API_PORT=${INFLUX_API_PORT:-"8086"}
API_URL="http://${INFLUX_HOST}:${INFLUX_API_PORT}"

sed "s#http://localhost:8086#${API_URL}#g" -i ${CONFIG_FILE}
sed -e "s/database = \"telegraf\"/database = \"$INFLUX_DB\"/g" -i ${CONFIG_FILE}
sed -e "s/# username = \"telegraf\"/username = \"$INFLUX_USER\"/g" -i ${CONFIG_FILE}
sed -e "s/# password = \"metricsmetricsmetricsmetrics\"/password = \"$INFLUX_PASS\"/g" -i ${CONFIG_FILE}


telegraf -config ${CONFIG_FILE}
