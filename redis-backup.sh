#!/bin/bash
export REDIS_MASTER_IP=$(redis-cli -h backend-redis-sentinel -p 26379 --csv SENTINEL get-master-addr-by-name mymaster |awk -F, '{print $1}'|sed -e 's/^"//' -e 's/"$//') 
echo $REDIS_MASTER_IP
export REDIS_BACKUP_STATUS=$(redis-cli -h $REDIS_MASTER_IP -p 6379 bgsave) 
echo $REDIS_BACKUP_STATUS
date -d @$(redis-cli -h $REDIS_MASTER_IP -p 6379 lastsave | cut -d ' ' -f1) 
export REDIS_MASTER=$(oc get pods -lapp=backend-redis -o custom-columns=NAME:.metadata.name,IP:.status.podIP --no-headers | grep $REDIS_MASTER_IP| cut -d ' ' -f1)
