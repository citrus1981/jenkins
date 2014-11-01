FROM citrus1981/base

RUN curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.rpm && \
yum install -y ./*.rpm && \
rm *.rpm

EXPOSE 8080
EXPOSE 8009
ENV JENKINS_HOME /jenkins
VOLUME /jenkins
RUN mkdir /tmp/daemon && chown daemon:daemon /tmp/daemon && usermod -d /tmp/daemon daemon
RUN curl -L -O http://mirrors.jenkins-ci.org/war/latest/jenkins.war
USER daemon
CMD ["java", "-jar", "/jenkins.war", "--httpPort=8080", "--ajp13Port=8009", "--webroot=/tmp/webroot"]
