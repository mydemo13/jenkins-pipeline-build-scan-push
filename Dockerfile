FROM ubuntu:focal

RUN apt-get update   && \
    apt-get -y upgrade   && \
    apt-get -y --no-install-recommends install openssl shellinabox ca-certificates iputils-ping wget jq curl dnsutils && \
    adduser lab --gecos "Me,Office,WorkPhone,HomePhone" --disabled-password  && \
    echo 'lab:$6$88GqT260$I8mtFOPBqCSeDWUdDcWBV0oDR1c2NAbg7WFh/6n6cb60sWdXhLJDQ6ELEAIErDr2p5syvVZkcsualGt4pC8Es1' | chpasswd --encrypted 

LABEL version="1.1"
LABEL description="Test with Labels in Image"
LABEL application="true"
LABEL deployment="QA"

ENV MYSQL_HOST=DB_Server
ENV MYSQL_USER=operations
ENV MYSQL_PASSWORD=5TTnvuTDJJSqikdyfvueew

EXPOSE 4200

ENTRYPOINT ["shellinaboxd", "-s", "/:LOGIN", "--disable-ssl"]
