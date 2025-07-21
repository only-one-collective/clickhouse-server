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

# Corrigir permissões para funcionar no Render
RUN chown -R clickhouse:clickhouse /var/lib/clickhouse && \
    chown -R clickhouse:clickhouse /var/log/clickhouse-server && \
    chown -R clickhouse:clickhouse /etc/clickhouse-server

# Criar script de inicialização que muda para usuário clickhouse
RUN echo '#!/bin/bash' > /docker-entrypoint.sh && \
    echo 'exec su-exec clickhouse clickhouse-server --config-file=/etc/clickhouse-server/config.xml' >> /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

EXPOSE 8123

CMD ["/docker-entrypoint.sh"]
