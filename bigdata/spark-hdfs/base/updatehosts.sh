#!/bin/bash
if [ ! -f /tmp/hosts.orig ]; then
    cp -rf /etc/hosts /tmp/hosts.orig
fi
echo "$(cat /tmp/hosts.orig)" > temp
$SERF_HOME/bin/serf members -status=alive | while read line ;do
  NEXT_HOST=$(echo $line|cut -d' ' -f 1)
  NEXT_SHORT=${NEXT_HOST%%.*}
  NEXT_ADDR=$(echo $line|cut -d' ' -f 2)
  NEXT_IP=${NEXT_ADDR%%:*}
  echo "$NEXT_IP        $NEXT_SHORT"
done >> temp
echo "$(cat temp)" > /etc/hosts
rm -rf temp
