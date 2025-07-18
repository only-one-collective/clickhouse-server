FROM clickhouse/clickhouse-server:latest

# Exponha as portas
EXPOSE 8123 9000

# Use a configuração padrão
CMD ["clickhouse-server"]