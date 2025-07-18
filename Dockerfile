FROM clickhouse/clickhouse-server:latest

RUN echo '<clickhouse>' > /etc/clickhouse-server/config.d/network.xml && \
    echo '    <listen_host>::</listen_host>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <listen_host>0.0.0.0</listen_host>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <http_port>8123</http_port>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '</clickhouse>' >> /etc/clickhouse-server/config.d/network.xml

EXPOSE 8123 9000

CMD ["clickhouse-server"]