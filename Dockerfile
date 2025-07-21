FROM clickhouse/clickhouse-server:latest

RUN echo '<clickhouse>' > /etc/clickhouse-server/config.d/network.xml && \
    echo '    <listen_host>0.0.0.0</listen_host>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <http_port>8123</http_port>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <tcp_port>9000</tcp_port>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <mysql_port>9004</mysql_port>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '</clickhouse>' >> /etc/clickhouse-server/config.d/network.xml

RUN echo '<clickhouse>' > /etc/clickhouse-server/config.d/logging.xml && \
    echo '    <logger>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '        <level>warning</level>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '        <console>true</console>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '    </logger>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '</clickhouse>' >> /etc/clickhouse-server/config.d/logging.xml

EXPOSE 8123

CMD ["clickhouse-server"]
