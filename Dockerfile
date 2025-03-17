# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
RUN set -xe \
    && addgroup pulse \
#
    # # if needed, use an older repository for an older version, e.g.
    && REPO=3.17 \
    && { \
        echo "http://dl-cdn.alpinelinux.org/alpine/v${REPO}/main"; \
        echo "http://dl-cdn.alpinelinux.org/alpine/v${REPO}/community"; \
    } > /tmp/repo${REPO} \
    && apk add --no-cache \
        --repositories-file "/tmp/repo${REPO}" \
#
    # # or get the current available packages with
    # && apk add --no-cache --purge -uU \
        alsa-plugins-pulse \
        alsa-utils \
        dbus-x11 \
        ffmpeg-libs \
        icu-libs \
        iso-codes \
        libcanberra-gtk3 \
        libexif \
        linux-firmware-i915 \
        mesa-dri-gallium \
        mesa-gl \
        mesa-va-gallium \
        # # swrast available since v3.17
        # mesa-vulkan-swrast \
        pango \
        pulseaudio \
        udev \
        unzip \
        zlib-dev \
#
        chromium \
        # angle available since 3.14, unavailable since v3.17
        # chromium-angle \
        chromium-chromedriver \
        # # qt5 shim available since v3.18
        # chromium-qt5 \
        # swiftshader available since 3.14
        chromium-swiftshader \
#
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
VOLUME /home/${S6_USER:-alpine}/ /home/${S6_USER:-alpine}/Downloads/
#
# WORKDIR /home/${S6_USER:-alpine}/
#
ENTRYPOINT ["/usershell"]
#
CMD ["/usr/bin/chromium-browser"]
# CMD ["/usr/bin/chromium-browser", "--no-sandbox"]
