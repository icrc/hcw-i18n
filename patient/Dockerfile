ARG HCW_PATIENT_VERSION
FROM iabsis/hcw-patient:${HCW_PATIENT_VERSION} AS i18n-layer
USER root
RUN apt update && apt install -y jq && rm -rf /var/lib/apt/lists/*
COPY assets/* /usr/share/nginx/html/assets/i18n
RUN bash /usr/share/nginx/html/assets/i18n/combine.sh


FROM iabsis/hcw-patient:${HCW_PATIENT_VERSION}

COPY --from=i18n-layer /usr/share/nginx/html/assets/i18n/*.json /usr/share/nginx/html/assets/i18n/
