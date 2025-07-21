FROM clickhouse/clickhouse-server:latest

RUN echo '<clickhouse>' > /etc/clickhouse-server/config.d/network.xml && \
    echo '    <listen_host>0.0.0.0</listen_host>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <http_port>8123</http_port>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <!-- TCP and MySQL ports disabled for web service -->' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <tcp_port remove="1"/>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '    <mysql_port remove="1"/>' >> /etc/clickhouse-server/config.d/network.xml && \
    echo '</clickhouse>' >> /etc/clickhouse-server/config.d/network.xml

RUN echo '<clickhouse>' > /etc/clickhouse-server/config.d/logging.xml && \
    echo '    <logger>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '        <level>warning</level>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '        <console>true</console>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '    </logger>' >> /etc/clickhouse-server/config.d/logging.xml && \
    echo '</clickhouse>' >> /etc/clickhouse-server/config.d/logging.xml

RUN chown -R clickhouse:clickhouse /var/lib/clickhouse && \
    chown -R clickhouse:clickhouse /var/log/clickhouse-server && \
    chown -R clickhouse:clickhouse /etc/clickhouse-server

RUN echo '#!/bin/bash' > /fix-permissions.sh && \
    echo 'echo "=== FIXING PERMISSIONS ===" ' >> /fix-permissions.sh && \
    echo 'ls -la /var/lib/clickhouse/ || echo "Directory does not exist yet"' >> /fix-permissions.sh && \
    echo 'mkdir -p /var/lib/clickhouse/data /var/lib/clickhouse/metadata /var/lib/clickhouse/access' >> /fix-permissions.sh && \
    echo 'chown -R clickhouse:clickhouse /var/lib/clickhouse' >> /fix-permissions.sh && \
    echo 'chmod -R 750 /var/lib/clickhouse' >> /fix-permissions.sh && \
    echo 'ls -la /var/lib/clickhouse/' >> /fix-permissions.sh && \
    echo 'echo "=== STARTING CLICKHOUSE ===" ' >> /fix-permissions.sh && \
    echo 'exec /entrypoint.sh "$@"' >> /fix-permissions.sh && \
    chmod +x /fix-permissions.sh

EXPOSE 8123

CMD ["/fix-permissions.sh"]
