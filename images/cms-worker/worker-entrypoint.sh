#/bin/bash
set -e
#
# k8s-cms
# Worker Entrypoint Script
#

# determine if we are execing a command or worker proper
if [ "$@" != "cmsWorker" ]
then
    exec $@
fi

# determine worker shard no.
if [ -n "$CMS_WORKER_NAME" ]
then
    # extract worker shard no. from worker name
    CMS_WORKER_SHARD=$(printf "$CMS_WORKER_NAME" | \
        sed -e 's/.*worker-\([0-9]*\).*/\1/g')
else
    CMS_WORKER_SHARD=${CMS_WORKER_SHARD:-"0"}
fi

exec /cms/scripts/cmsWorker $CMS_WORKER_SHARD