#!/bin/bash
EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` payloadsize "
  exit $E_BADARGS
fi
DIR=`dirname \`readlink -m $0\``
sudo click-install -uct24 PAYLOAD_SIZE=$1 -f ${DIR}/../xia_mq_24.click