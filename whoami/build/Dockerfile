ARG baseImage
ARG alpineImage

FROM ${baseImage} AS base

FROM ${alpineImage}
COPY --from=base /whoami /

ENTRYPOINT [ "/whoami" ]

EXPOSE 80

HEALTHCHECK CMD [ "wget", "--spider", "localhost" ]