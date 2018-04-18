FROM akhilreddyjirra/apline-jre8-tomcat-ist 
#ARG FILEBEAT_VERSION=5.0.0-alpha1-x86_64
ARG FILEBEAT_VERSION=6.2.4-linux-x86_64
ENV GLIBC 2.27-r0
ENV FILEBEAT_VERSION ${FILEBEAT_VERSION}
ARG FILEBEAT_DOWNLOAD_URL=https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}.tar.gz
ENV FILEBEAT_DOWNLOAD_URL ${FILEBEAT_DOWNLOAD_URL}

# Install curl
RUN apk add --update curl

# Install the library files 
RUN curl -L https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -L https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC}/glibc-${GLIBC}.apk -o glibc-${GLIBC}.apk && \
    apk add glibc-${GLIBC}.apk && \
    rm glibc-${GLIBC}.apk

# Install filebeat
RUN curl -s ${FILEBEAT_DOWNLOAD_URL} | tar zx -C /tmp && \
    mv /tmp/filebeat-${FILEBEAT_VERSION}/filebeat /bin/filebeat

# ADD config /etc/filebeat/
# RUN apk del curl && \
#    rm -rf /var/cache/apk/*

# config file
ADD filebeat.yml /etc/filebeat/filebeat.yml
RUN chmod 644 /etc/filebeat/filebeat.yml

# CA cert
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

# Staup script
ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]
