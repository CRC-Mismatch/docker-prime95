FROM alpine:latest

MAINTAINER CRC-Mismatch

ENV PRIME_USER CRC-Mismatch

RUN apk add --no-cache && \
    apt-get -y update && \
    apt-get install -yq curl 

RUN mkdir -p /opt/mprime && curl -sSL "$(curl -s https://www.mersenne.org/download/ | grep -Po -m 1 'href=\"\K[0-9a-z:/._-]+?linux64.+?(?=\")')" | tar -C /opt/mprime -xvz --keep-newer-files

COPY prime95 /
RUN chmod +x /prime95

VOLUME /opt/mprime

WORKDIR /opt/mprime
CD /opt/mprime

ENTRYPOINT ['/prime95']
