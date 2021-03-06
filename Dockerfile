FROM gliderlabs/alpine
MAINTAINER Joeri van Dooren <ure@mororless.be>

RUN apk --update add apache2-webdav && rm -f /var/cache/apk/* && \

mkdir -p /app/dav && chown -R apache:apache /app && \
mkdir /run/apache2/ && \
chmod a+rwx /run/apache2/

# Apache config
ADD httpd.conf /etc/apache2/httpd.conf

# Run scripts
ADD scripts/run.sh /scripts/run.sh

RUN mkdir /scripts/pre-exec.d && \
mkdir /scripts/pre-init.d && \
chmod -R 755 /scripts && chmod a+rw /etc/passwd

# test file
ADD app/dav/testfile /app/dav/testfile

# add password file
ADD app/users.password /app/users.password

# Exposed Port
EXPOSE 8080

# VOLUME /app
WORKDIR /app

ENTRYPOINT ["/scripts/run.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Alpine linux based Apache WebDAV Container" \
      io.k8s.display-name="alpine apache php" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,html,apache,webdav" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
