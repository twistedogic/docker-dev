#!/bin/bash
$SERF_HOME/bin/serf members -status=alive | while read line ;do
  NEXT_ADDR=$(echo $line|cut -d' ' -f 2)
  NEXT_IP=${NEXT_ADDR%%:*}
  echo "$NEXT_IP:54321"
done >> temp
echo "$(cat temp)" > /opt/flatfile.txt
rm -rf temp
