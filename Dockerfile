
FROM debian:stable-slim AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y libxml2-utils curl

WORKDIR /ut

ADD . .

RUN bash ./UrTUpdater_Ded.sh -q
RUN chmod +x Quake3-UrT-Ded.x86_64


FROM scratch

COPY --from=build /ut /ut

WORKDIR /ut

ENTRYPOINT ["./Quake3-UrT-Ded.x86_64"]

EXPOSE 27960:27960/udp
