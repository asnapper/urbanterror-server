FROM debian:stable-slim AS build
LABEL maintainer="Matthias Löffel <matthias.loeffel@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y libxml2-utils curl

WORKDIR /ut
ADD updater-cfg .
RUN curl -sSL 'https://raw.githubusercontent.com/FrozenSand/UrTUpdater/master/ded/UrTUpdater_Ded.sh' | bash -s -- -q

FROM scratch

COPY --from=build /ut /ut
# unfortunately, ioqauke binaries are not statically linked
COPY --from=build /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/ 
COPY --from=build /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/
COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/

WORKDIR /ut
ENTRYPOINT ["./Quake3-UrT-Ded.x86_64"]
EXPOSE 27960:27960/udp
