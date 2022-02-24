#!/bin/bash
#
# k8s-cms
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

if [ "$CMS_DB" = "0.0.0.0" ] 
then
    # DB requires connection to print
    env CMS_DB="localhost" envsubst < "$ORIG_CMS_CONFIG" > "/etc/$(basename $CMS_CONFIG)"
    # running as DB - require root permissions
    exec bash -c "$*"
elif [ -n "$CMS_DB" ] 
then
    # not running as DB but db present
    # database dependency check: wait for database to start
    CMS_DB_WAIT=${CMS_DB_WAIT:-"30"} # how long to wait for the database
    if ! /scripts/wait-for-it.sh -t $CMS_DB_WAIT -h $CMS_DB -p 5432
    then
        # could not extablish database connection in time
        exit 1
    fi
fi

# lose root privilege to tighten security
exec su --preserve-environment -c "$*" cmsuser 