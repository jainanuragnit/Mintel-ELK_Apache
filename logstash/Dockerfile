ARG ELK_VERSION

# https://www.docker.elastic.co/
FROM docker.elastic.co/logstash/logstash:${ELK_VERSION}
COPY ./WEB_access_log_20181017-135516.log /var/log
# plugin added
RUN logstash-plugin install logstash-filter-json
