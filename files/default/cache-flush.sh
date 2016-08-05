#!/bin/sh

. /etc/profile.d/cf-stack-environment.sh

REDIS_KEY="zc:*:$1*"
#echo "Clearing redis keys $REDIS_KEY..."
for key in `echo "KEYS $REDIS_KEY" | /bin/redis-cli -h $ELASTICACHE_CACHE_SERVER | awk '{print $1}'`
do
  echo DEL $key
done | /bin/redis-cli -h $ELASTICACHE_CACHE_SERVER > /dev/null 2>&1
