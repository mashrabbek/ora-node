FROM ubuntu:bionic

RUN apt-get update && apt-get install -y -q --no-install-recommends \
        unzip \
        curl \
        ca-certificates \
        rpm \
        alien \
        libaio1

ADD /linux /assets

RUN mkdir /usr/lib/oracle/19.11/client64/network/admin -p

#COPY /config /usr/lib/oracle/19.11/client64/network/admin

RUN chmod 0777 /usr/lib/oracle/19.11/client64/network/admin

RUN alien -i /assets/oracle-instantclient19.11-basic-19.11.0.0.0-1.x86_64.rpm &&\
    alien -i /assets/oracle-instantclient19.11-devel-19.11.0.0.0-1.x86_64.rpm &&\
    alien -i /assets/oracle-instantclient19.11-sqlplus-19.11.0.0.0-1.x86_64.rpm

ENV ORACLE_HOME=/usr/lib/oracle/19.11/client64
ENV TNS_ADMIN=/usr/lib/oracle/19.11/client64/network/admin
ENV LD_LIBRARY_PATH=/usr/lib/oracle/19.11/client64/lib
ENV PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/oracle/19.11/client64/bin
#ENV ORACLE_SID=ctrd

RUN echo "/usr/lib/oracle/19.11/client64/lib" > /etc/ld.so.conf.d/oracle.conf && ldconfig

# installing the nodejs:14

RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get install --yes nodejs
RUN npm i -g pm2