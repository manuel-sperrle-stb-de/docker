ARG baseImage
ARG alpineImage

FROM ${baseImage} AS base

FROM ${alpineImage}
COPY --from=base /watchtower /

ENTRYPOINT [ "/watchtower" ]

HEALTHCHECK --interval=15s --timeout=5s --start-period=5s --retries=3 CMD ls -l /proc/*/exe | grep watchtower -q