FROM centos:7

MAINTAINER Marcin Gasior <marcin.gasior@gmail.com>

RUN groupadd -r dse --gid=999 \
    && useradd -r -g dse --uid=999 dse

RUN echo "[datastax]" | tee --append   /etc/yum.repos.d/datastax.repo && \
    echo "name = DataStax Repo for DataStax Enterprise" | tee --append   /etc/yum.repos.d/datastax.repo && \
    echo "baseurl=https://william.palluault%40gmail.com:Aib12345@rpm.datastax.com/enterprise" | tee --append   /etc/yum.repos.d/datastax.repo && \
    echo "enabled=1" | tee --append /etc/yum.repos.d/datastax.repo && \
    echo "gpgcheck=0" | tee --append /etc/yum.repos.d/datastax.repo && \
    yum update -y && \
    yum install -y git wget unzip which dse-full-4.8.8-1 && \
    yum clean all

ENV JAVA_MAJOR=8 \
    JAVA_UPDATE=92 \
    JAVA_BUILD=14

RUN wget -nv --no-cookies --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm" -O /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm && \
     yum localinstall -y /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm && \
     rm -f /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm

CMD "/etc/init.d/dse start"
