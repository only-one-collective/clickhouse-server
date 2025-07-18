FROM clickhouse/clickhouse-server:latest

RUN echo '<clickhouse><listen_host>::</listen_host><listen_host>0.0.0.0</listen_host><http_port>8123</http_port></clickhouse>' > /etc/clickhouse-server/config.d/listen.xml

RUN echo '<clickhouse><http_handlers><rule><url>/ping</url><methods>GET</methods><handler><type>static</type><status>200</status><content_type>text/plain</content_type><response_content>Ok.</response_content></handler></rule></http_handlers></clickhouse>' > /etc/clickhouse-server/config.d/ping.xml

EXPOSE 8123 9000

CMD ["clickhouse-server"]