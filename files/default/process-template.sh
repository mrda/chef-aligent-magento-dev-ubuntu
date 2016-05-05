#!/bin/bash

template=$1
target=$2

. /etc/profile.d/cf-stack-environment.sh

if [ -f $template ]; then
    sed -e "s/%BACKEND_ELB_HOST_NAME%/$BACKEND_ELB_HOST_NAME/g" \
        -e "s/%AWS_REGION%/$AWS_REGION/" \
        -e "s/%RDS_MYSQL_HOSTNAME%/$RDS_MYSQL_HOSTNAME/" \
        -e "s/%RDS_MYSQL_DATABASE%/$RDS_MYSQL_DATABASE/" \
        -e "s/%RDS_MYSQL_USERNAME%/$RDS_MYSQL_USERNAME/" \
        -e "s/%RDS_MYSQL_PASSWORD%/$RDS_MYSQL_PASSWORD/" \
        -e "s/%ELASTICACHE_CACHE_SERVER%/$ELASTICACHE_CACHE_SERVER/" \
        -e "s/%ELASTICACHE_CACHE_PORT%/$ELASTICACHE_CACHE_PORT/" \
        -e "s/%ELASTICACHE_CACHE_PREFIX%/$ELASTICACHE_CACHE_PREFIX/" \
        -e "s/%ELASTICACHE_SESSION_SERVER%/$ELASTICACHE_SESSION_SERVER/" \
        -e "s/%ELASTICACHE_SESSION_PORT%/$ELASTICACHE_SESSION_PORT/" \
        < $template > $target
fi

