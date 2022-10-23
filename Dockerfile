ARG ALPINE_VERSION=3.16

FROM alpine:${ALPINE_VERSION} as fspatch

RUN apk add --no-cache curl gzip                    && \
    export SUPERVISORD_LATEST=$(curl -sD - -XHEAD https://github.com/ochinchina/supervisord/releases/latest \
    | egrep -i "^location"                             \
    | cut -d ' ' -f 2                                  \
    | rev | cut -d '/' -f 1 | rev | tr -d '\r' | sed "s/^v//g") && \
    curl -Lo supervisord.tar.gz                        \
        https://github.com/ochinchina/supervisord/releases/download/v${SUPERVISORD_LATEST}/supervisord_${SUPERVISORD_LATEST}_Linux_64-bit.tar.gz && \
    tar -xf supervisord.tar.gz                      && \
    mv supervisord_* supervisord

WORKDIR /output

COPY ./supervisor.conf ./etc/supervisor.conf

RUN mkdir -p ./usr/local/bin                        && \
    cp /supervisord/supervisord                        \
        ./usr/local/bin/supervisord                 && \
    chmod 600 ./etc/supervisor.conf

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache                                 \
        bash                                           \
        nfs-utils                                   && \
    echo '/data *(rw,fsid=0,sync,no_subtree_check)'    \
        >> /etc/exports

COPY --from=fspatch /output /

ENTRYPOINT [ "/usr/local/bin/supervisord" ]
CMD [ "-c", "/etc/supervisor.conf" ]
