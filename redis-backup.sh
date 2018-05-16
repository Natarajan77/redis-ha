#!/bin/bash
export REDIS_MASTER_IP=$(/opt/rh/rh-redis32/root/usr/bin/redis-cli -h backend-redis-sentinel -p 26379 --csv SENTINEL get-master-addr-by-name mymaster |awk -F, '{print $1}'|sed -e 's/^"//' -e 's/"$//') 
echo $REDIS_MASTER_IP
export REDIS_BACKUP_STATUS=$(/opt/rh/rh-redis32/root/usr/bin/redis-cli -h $REDIS_MASTER_IP -p 6379 bgsave) 
echo $REDIS_BACKUP_STATUS
date -d @$(/opt/rh/rh-redis32/root/usr/bin/redis-cli -h $REDIS_MASTER_IP -p 6379 lastsave | cut -d ' ' -f1) 
