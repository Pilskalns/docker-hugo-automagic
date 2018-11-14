FROM debian:stretch-slim
LABEL maintainer="Andžs Pilskalns"

# Must be set for image build
ARG CLONE_DIR
ARG HUGO_VERSION=0.51


ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

RUN apt-get -qq update \
	# && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends python-pygments git ca-certificates asciidoc curl \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends git ca-certificates curl \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sL -o /tmp/hugo.deb \
    https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb && \
    mkdir /usr/share/work

WORKDIR /usr/share/work

# Automatically build site
ONBUILD ADD site/ /usr/share/work
ONBUILD RUN hugo -s ${CLONE_DIR} -d /usr/share/work \ ls -lha
