
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

# unfortunately, ioqauke binaries are not statically linked
COPY --from=build /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/ 
COPY --from=build /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/
COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/

WORKDIR /ut
ENV PATH=/ut

ENTRYPOINT ["./Quake3-UrT-Ded.x86_64"]

EXPOSE 27960:27960/udp
