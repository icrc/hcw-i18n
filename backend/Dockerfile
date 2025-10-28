ARG HCW_BACKEND_VERSION
FROM iabsis/hcw-backend:${HCW_BACKEND_VERSION} AS init-layer
ARG HCW_BACKEND_VERSION
ENV HCW_BACKEND_VERSION=${HCW_BACKEND_VERSION}

FROM init-layer AS i18n-layer
USER root
COPY assets /usr/src/app/config/locales/
RUN cp -nv /usr/src/app/config/locales/i18n-override/*.json /usr/src/app/config/locales/ && /usr/src/app/config/locales/replace-i18n.sh

FROM init-layer
COPY --from=i18n-layer /usr/src/app/config/locales/*.json /usr/src/app/config/locales/
COPY --from=i18n-layer /usr/src/app/config/locales/*.orig /tmp/orig/