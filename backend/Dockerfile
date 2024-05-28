ARG HCW_BACKEND_VERSION
FROM iabsis/hcw-backend:${HCW_BACKEND_VERSION} AS i18n-layer
USER root
RUN apt update && apt install -y jq && rm -rf /var/lib/apt/lists/*
COPY assets/* /usr/src/app/config/locales/
RUN bash /usr/src/app/config/locales/combine.sh


FROM iabsis/hcw-backend:${HCW_BACKEND_VERSION}

COPY --from=i18n-layer /usr/src/app/config/locales/*.json /usr/src/app/config/locales/
