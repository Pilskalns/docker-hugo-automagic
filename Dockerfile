FROM debian:stretch-slim
LABEL name="Hugo Builder image"
LABEL maintainer="Andžs Pilskalns"

# Must be set for image build
ARG HUGO_VERSION=0.51


ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.deb

RUN apt-get -qq update \
	# && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends python-pygments git ca-certificates asciidoc curl \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends python-pygments git ca-certificates curl \
	# && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends \
    git \
    ssh-client \
    ca-certificates curl \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sL -o /tmp/hugo.deb \
    https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb
    # rm /tmp/hugo.deb && \
    # mkdir /usr/share/work

# WORKDIR /usr/share/work
# WORKDIR /opt/atlassian/pipelines/agent/build/

# Automatically build site
# ONBUILD ADD site/ /usr/share/work
# ONBUILD RUN hugo
# ONBUILD RUN hugo version \ hugo -s ${CLONE_DIR} -d /usr/share/work \ ls -lha
# ONBUILD RUN touch /opt/atlassian/pipelines/agent/build/onbuildtest.dat
# ONBUILD RUN hugo -d /usr/share/work/

ENTRYPOINT hugo