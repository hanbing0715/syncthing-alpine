FROM alpine:latest
MAINTAINER MagicHice <hanbing0715@gmail.com>

ENV VERSION v0.12.22
ENV RELEASE syncthing-linux-amd64-$VERSION

RUN apk add --update wget ca-certificates

RUN mkdir /syncthing

WORKDIR /syncthing

RUN wget -q  https://github.com/syncthing/syncthing/releases/download/$VERSION/$RELEASE.tar.gz

RUN tar zxf $RELEASE.tar.gz

RUN cp /syncthing/$RELEASE/syncthing /syncthing

RUN rm -rf $RELEASE.tar.gz

RUN rm -rf /syncthing/$RELEASE

RUN rm -rf /var/cache/apk/*

VOLUME /syncthing/stroge

EXPOSE 8384/tcp 22000/tcp 21025/udp

CMD ["-no-browser", "-no-restart", "-gui-address=0.0.0.0:8384", "-home=/syncthing/stroge"]

ENTRYPOINT ["/syncthing/syncthing"]