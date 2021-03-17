#! /bin/bash
SOURCE_CONFIG_FILE="/etc/tinyproxy/tinyproxy.conf"
DEST_CONFIG_FILE="/opt/tinyproxy.conf"
if [[ ! -f ${DEST_CONFIG_FILE} ]]; then
  cp ${SOURCE_CONFIG_FILE} ${DEST_CONFIG_FILE}
fi
for i in ${ALLOW_LIST}; do
  if [[ $(grep -c -E "^Allow ${i}" ${DEST_CONFIG_FILE}) -eq 0 ]]; then
    echo "Allow ${i}" | tee -a ${DEST_CONFIG_FILE}
  fi
done

tinyproxy -c ${DEST_CONFIG_FILE} -d