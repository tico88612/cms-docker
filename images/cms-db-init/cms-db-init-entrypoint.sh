#!/bin/bash
#
# cms-db-init
# Docker Entrypoint
#

## configuable env var
# determine path of configuration
CMS_CONFIG=${CMS_CONFIG:-"/cms/config/cms.conf"}
CMS_RANKING_CONFIG=${CMS_RANKING_CONFIG:-"/cms/config/cms.ranking.conf"}
ORIG_CMS_CONFIG="$CMS_CONFIG"
ORIG_CMS_RANKING_CONFIG="$CMS_RANKING_CONFIG"
# defaults
export POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-"YWaEjprTaRn3XGKuf5K3oB4vmVUrtCvh"}

## setup config
# populates configuration with environment values
envsubst < $ORIG_CMS_CONFIG > "/etc/$(basename $CMS_CONFIG)"
envsubst < $ORIG_CMS_RANKING_CONFIG > "/etc/$(basename $CMS_RANKING_CONFIG)"
# update env vars pointing to populated config path
export CMS_CONFIG="/etc/$(basename $CMS_CONFIG)"
export CMS_RANKING_CONFIG="/etc/$(basename $CMS_RANKING_CONFIG)"

CMS_DB_WAIT=${CMS_DB_WAIT:-"30"} # how long to wait for the database
if ! /scripts/wait-for-it.sh $CMS_DB:5432 -t $CMS_DB_WAIT
then
    # could not extablish database connection in time
    exit 1
fi

# run db setup scripts
exec bash -c '/cms/scripts/cmsInitDB'