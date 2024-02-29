FROM fedora:39

WORKDIR /isogenerator

RUN dnf install -y make lorax xorriso podman && \
  dnf clean all

COPY ./lorax_templates /isogenerator/lorax_templates
COPY ./xorriso /isogenerator/xorriso
COPY ./Makefile /isogenerator/

VOLUME /isogenerator/output
