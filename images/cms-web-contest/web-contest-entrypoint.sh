#/bin/bash
set -e
#
# k8s-cms
# Contest Web Server Entrypoint
#

# determine if we are execing a command or contest web server proper
if [ "$@" != "cmsContestWebServer" ]
then
    exec $@
fi


# figure out the contest id that this contest server targets.
CONTEST_ID=${CMS_CONTEST_ID:-"DEFAULT"}
POLL_INTERVAL=${CMS_POLL_INTERVAL:-"15"}
if [ "$CONTEST_ID" = "DEFAULT" ]
then
    # configure contest web server to host all contests
    /cms/scripts/cmsContestWebServer -c ALL 0
else
    exec /cms/scripts/cmsContestWebServer --contest-id $CONTEST_ID 0
fi
