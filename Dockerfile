# Unofficial. Replaces Tomcat 9 / Java 11 of the official image with Tomcat 11 / Temurin 17.
# Needed next to this file: jdk17.tar.gz, tomcat11.tar.gz, lib/ (from the Premium package), server.xml
FROM headwindmdm/hmdm:0.1.8

COPY jdk17.tar.gz /tmp/jdk17.tar.gz
COPY tomcat11.tar.gz /tmp/tomcat11.tar.gz
COPY server.xml /tmp/server.xml
COPY lib/ /tmp/hmdm-lib/

RUN rm -rf /opt/java/openjdk \
 && mkdir -p /opt/java/openjdk \
 && tar xzf /tmp/jdk17.tar.gz -C /opt/java/openjdk --strip-components=1 \
 && rm -rf /usr/local/tomcat \
 && mkdir -p /usr/local/tomcat \
 && tar xzf /tmp/tomcat11.tar.gz -C /usr/local/tomcat --strip-components=1 \
 && rm -rf /usr/local/tomcat/webapps/* \
 && cp /tmp/hmdm-lib/* /usr/local/tomcat/lib/ \
 && cp /tmp/server.xml /usr/local/tomcat/conf/server.xml \
 && mkdir -p /usr/local/tomcat/conf/Catalina/localhost /usr/local/tomcat/ssl \
 && chmod +x /usr/local/tomcat/bin/*.sh \
 && rm -rf /tmp/jdk17.tar.gz /tmp/tomcat11.tar.gz /tmp/server.xml /tmp/hmdm-lib
