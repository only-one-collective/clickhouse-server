FROM clickhouse/clickhouse-server:latest

# Configure o ClickHouse para responder em todas as interfaces
RUN echo '<clickhouse><listen_host>::</listen_host><listen_host>0.0.0.0</listen_host></clickhouse>' > /etc/clickhouse-server/config.d/listen.xml

# Exponha as portas
EXPOSE 8123 9000

# Use a configuração padrão
CMD ["clickhouse-server"]