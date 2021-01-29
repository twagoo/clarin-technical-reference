FROM registry.gitlab.com/clarin-eric/docker-alpine-base:1.4.3

ARG MAKE_VERSION=4.2.1-r2 \
    PYTHON_VERSION=3.7.7-r1 \
    PIP_VERSION=21.0 \
    TARGET_DIR=/out

RUN apk add --no-cache \
    "make=${MAKE_VERSION}" \
    "python3=${PYTHON_VERSION}"

COPY ./ /tr-build/

WORKDIR /tr-build

RUN python3 -m venv venv \
    && source venv/bin/activate \
    && pip install "pip==${PIP_VERSION}" \
    && pip install -r 'requirements.txt' \
    && make linkcheck html \
    && mkdir -p "${TARGET_DIR}" \
    && cp -r _build/* "${TARGET_DIR}"

ENTRYPOINT ["tail", "-f", "/dev/null"]
