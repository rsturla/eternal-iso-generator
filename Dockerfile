ARG VERSION=39
FROM fedora:${VERSION}

ARG VERSION
ENV ARCH="x86_64"
ENV VARIANT="desktop"
ENV IMAGE_NAME="lumina"
ENV IMAGE_REPO="ghcr.io/rsturla/eternal-linux"
ENV IMAGE_TAG="39"
ENV USE_WEB_INSTALLER="false"

COPY ./lorax_templates /isogenerator/lorax_templates
COPY ./xorriso /isogenerator/xorriso
COPY ./Makefile /isogenerator/

WORKDIR /isogenerator

RUN dnf install -y make && \
  make install-deps && \
  dnf clean all

VOLUME /isogenerator/output

ENTRYPOINT ["sh", "-c", "make output/${IMAGE_NAME}-${IMAGE_TAG}.iso ARCH=${ARCH} VERSION=${VERSION} IMAGE_REPO=${IMAGE_REPO} IMAGE_NAME=${IMAGE_NAME} IMAGE_TAG=${IMAGE_TAG} USE_WEB_INSTALLER=${USE_WEB_INSTALLER}"]
