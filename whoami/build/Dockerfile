FROM traefik/whoami AS base

FROM alpine
COPY --from=base /whoami /

ENTRYPOINT [ "/whoami" ]

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=5s --start-period=5s --retries=3 CMD [ "wget", "--spider", "localhost" ]