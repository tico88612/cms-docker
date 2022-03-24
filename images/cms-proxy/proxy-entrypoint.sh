#/bin/bash
set -e
#
# k8s-cms
# Proxy Service Entrypoint
#

# determine if we are execing a command or proxyservice proper
if [ "$@" != "cmsProxyService" ]
then
    exec $@
fi

# figure out the contest id that this proxy service targets.
CONTEST_ID=${CMS_CONTEST_ID:-"DEFAULT"}
POLL_INTERVAL=${CMS_POLL_INTERVAL:-"15"}
CMS_PROXY_PORT=28600

# marker file for liveness probes
echo 1 > /tmp/is-healthy 

if [ "$CONTEST_ID" = "DEFAULT" ]
then
    
    # poll until a contest has been discovered
    while [ $? -eq 0 ]
    do
        # autoselect default contest
        touch /tmp/
        printf "\n" | ./scripts/cmsProxyService 0

        echo "Service ProxyService waiting for a contest to be created..."
        sleep $POLL_INTERVAL
    done
else
    exec /cms/scripts/cmsProxyService --contest-id $CONTEST_ID 0
fi

rm /tmp/is-healthy
