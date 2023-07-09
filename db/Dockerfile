FROM postgres:latest
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_USER=postgres
ENV POSTGRES_DB=postgres
# VOLUME [ "/data:/var/lib/postgresql/data" ]
COPY init_scripts/init.sql /docker-entrypoint-initdb.d/init.sql