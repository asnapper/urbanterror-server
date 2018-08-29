
FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y libxml2-utils curl

WORKDIR /ut

ADD . .

RUN bash ./UrTUpdater_Ded.sh -q

CMD ./Quake3-UrT-Ded.x86_64

EXPOSE 27960:27960/udp
