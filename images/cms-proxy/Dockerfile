FROM cms-base:latest

COPY images/cms-proxy/proxy-entrypoint.sh /scripts/
RUN chown -R cmsuser /scripts
RUN chmod -R u+x /scripts

EXPOSE 28600
ENTRYPOINT ["/scripts/cms-entrypoint.sh", "/scripts/proxy-entrypoint.sh"]
CMD ["cmsProxyService"]
