ARG HCW_PATIENT_VERSION
FROM iabsis/hcw-patient:${HCW_PATIENT_VERSION} AS init-layer
ARG HCW_PATIENT_VERSION
ENV HCW_PATIENT_VERSION=${HCW_PATIENT_VERSION}

FROM init-layer AS i18n-layer
USER root
RUN apt update && apt install -y jq && rm -rf /var/lib/apt/lists/* && rm /usr/share/nginx/html/assets/i18n/combine.sh
COPY assets /usr/share/nginx/html/assets/i18n
RUN cp -n /usr/share/nginx/html/assets/i18n/i18n-override/*.json /usr/share/nginx/html/assets/i18n/ && /usr/share/nginx/html/assets/i18n/combine.sh


FROM init-layer
COPY --from=i18n-layer /usr/share/nginx/html/assets/i18n/*.json /usr/share/nginx/html/assets/i18n/
COPY --from=i18n-layer /usr/share/nginx/html/assets/i18n/*.orig /tmp/orig/
