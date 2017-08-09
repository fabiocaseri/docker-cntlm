FROM alpine

ENV CNTLM_VERSION=0.92.3

RUN apk add --no-cache --virtual .build-deps \
        curl \
        gcc \
        make \
        musl-dev \
    && curl -SLO "http://kent.dl.sourceforge.net/project/cntlm/cntlm/cntlm%20${CNTLM_VERSION}/cntlm-${CNTLM_VERSION}.tar.gz" \
    && tar -xf "cntlm-${CNTLM_VERSION}.tar.gz" \
    && cd "cntlm-${CNTLM_VERSION}" \
    && ./configure && make && make install \
    && cd .. \
    && rm -Rf "cntlm-${CNTLM_VERSION}" \
    && rm "cntlm-${CNTLM_VERSION}.tar.gz" \
    && apk del .build-deps

ENV USERNAME=example \
    PASSWORD=UNSET \
    DOMAIN=example.com \
    PROXY=example.com:3128 \
    LISTEN=0.0.0.0:3128 \
    PASSLM=UNSET \
    PASSNT=UNSET \
    PASSNTLMV2=UNSET \
    AUTH=UNSET \
    FLAGS=FLAGS \
    GATEWAY=UNSET \
    NOPROXY=UNSET

EXPOSE 3128

COPY start.sh /start.sh

CMD ["/start.sh"]
