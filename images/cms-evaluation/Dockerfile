FROM tico88612/cms-base:latest

COPY config /cms/config

COPY images/cms-evaluation/evaluation-entrypoint.sh /scripts/
RUN chown -R cmsuser /scripts
RUN chmod -R u+x /scripts

EXPOSE 25000

ENTRYPOINT ["/scripts/cms-entrypoint.sh", "/scripts/evaluation-entrypoint.sh"]
CMD ["cmsEvaluationService"]
