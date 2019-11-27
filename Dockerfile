FROM alpine:latest

MAINTAINER CRC-Mismatch

ENV PRIME_USER CRC-Mismatch

RUN apk add --no-cache curl tar grep
RUN mkdir -p /opt/mprime && curl -sSL "$(curl -s https://www.mersenne.org/download/ | grep -Po -m 1 'href=\"\K[0-9a-z:/._-]+?linux64.+?(?=\")')" | tar -C /opt/mprime -xvz --keep-newer-files

COPY prime95 /opt/mprime
RUN chmod +x /opt/mprime/prime95

VOLUME /opt/mprime

WORKDIR /opt/mprime

ENTRYPOINT ['/opt/mprime/prime95']
