# Containers

## Monitoring stack

- [Influxdb][influx] - _An open-source distributed time series database with no external dependencies_
  - __login__   : root
  - __Password__: root

- [Grafana][grafana] - _The leading graph and dashboard builder for visualizing time series metrics_
  - __login__   : admin
  - __Password__: admin

- [Telegraf][telegraf] - _The plugin-driven server agent for reporting metrics into InfluxDB_
  - __database__: telegraf
- App + [statsd][statsd] client

---

## Resources

- [tutume/influxdb docker image][tutum-influx]
- [Influxdb + Telegraf for statsd compatible metrics][statsd]


[statsd]: https://influxdb.com/blog/2015/11/03/getting_started_with_influx_statsd.html?
[tutum-influx]: https://github.com/tutumcloud/influxdb
[influx]: https://influxdb.com/
[grafana]: http://grafana.org/
[telegraf]: https://github.com/influxdb/telegraf
