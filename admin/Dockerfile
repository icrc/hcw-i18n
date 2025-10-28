ARG HCW_ADMIN_VERSION

FROM iabsis/hcw-admin:${HCW_ADMIN_VERSION} AS init-layer
ARG HCW_ADMIN_VERSION
ENV HCW_ADMIN_VERSION=${HCW_ADMIN_VERSION}

FROM init-layer AS i18n-layer
USER root
RUN apt update && apt install -y jq && rm -rf /var/lib/apt/lists/*
COPY assets /usr/share/nginx/html/assets/translate
RUN /usr/share/nginx/html/assets/translate/replace-i18n.sh


FROM init-layer

COPY --from=i18n-layer /usr/share/nginx/html/assets/translate/*.json /usr/share/nginx/html/assets/translate/
COPY --from=i18n-layer /usr/share/nginx/html/assets/translate/*.orig /tmp/orig/
