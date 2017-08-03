#!/bin/bash
routerdb_files=$(find . -type f -name 'router.db' -mindepth 2)
for file in $routerdb_files; 
  do
      group=$(dirname $file | tr -d './')
      echo "group: $group"
      mkdir "new/$group"
      cat $file | while read node
        do
            if [[ $node =~ '#' ]]; then
                >&2 echo "skip comment $node"
                continue
            fi
            if [[ $node =~ ':down' ]]; then
                >&2 echo "skipped down $node"
                continue
            fi
            hostname=$(echo $node | cut -d ':' -f1)
            devicetype=$(echo $node | cut -d ':' -f2)
            if [ -z $devicetype ]; then
              unset devicetype
              continue;
            fi
            ipaddr=$(grep -E "^[0-9].*$hostname$" hosts | head -n 1 | awk '{print $1}')
            if [ -z $ipaddr ]; then
              >&2 echo "no ip addr found for $node"  
              continue
            fi
            echo "$group:$hostname:$ipaddr:$devicetype" 
            unset $devicetype
        done > "new/router.db"
  done
