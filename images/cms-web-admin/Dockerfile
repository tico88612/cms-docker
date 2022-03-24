FROM tico88612/cms-base:latest

COPY images/cms-web-admin/web-admin-entrypoint.sh /scripts
RUN chown -R cmsuser /scripts
RUN chmod -R u+x /scripts

COPY config /cms/config

EXPOSE 8889
EXPOSE 21100
ENTRYPOINT [ "/scripts/cms-entrypoint.sh", "/scripts/web-admin-entrypoint.sh" ]
CMD [ "cmsAdminWebServer" ]