ARG HCW_DOCTOR_VERSION
FROM iabsis/hcw-doctor:${HCW_DOCTOR_VERSION} AS init-layer
ARG HCW_DOCTOR_VERSION
ENV HCW_DOCTOR_VERSION=${HCW_DOCTOR_VERSION}

FROM init-layer AS i18n-layer
USER root
COPY assets /usr/share/nginx/html/assets/i18n
RUN cp -n /usr/share/nginx/html/assets/i18n/i18n-override/*.json /usr/share/nginx/html/assets/i18n/ && /usr/share/nginx/html/assets/i18n/replace-i18n.sh


FROM init-layer
COPY --from=i18n-layer /usr/share/nginx/html/assets/i18n/*.json /usr/share/nginx/html/assets/i18n/
COPY --from=i18n-layer /usr/share/nginx/html/assets/i18n/*.orig /tmp/orig/

USER root
RUN chmod a+rX /etc/nginx/ssl && chmod a+r /etc/nginx/ssl/ssl-cert-snakeoil.*
USER nginx

