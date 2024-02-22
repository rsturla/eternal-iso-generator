ARG VERSION=39
FROM fedora:${VERSION}

COPY ./lorax_templates /isogenerator/lorax_templates
COPY ./xorriso /isogenerator/xorriso
COPY ./Makefile /isogenerator/

WORKDIR /isogenerator

RUN dnf install -y make && \
  make install-deps && \
  dnf clean all

VOLUME /isogenerator/output
