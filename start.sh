#!/bin/sh
set -e

if [ "${PROXY}" ] ; then
  echo "Proxy ${PROXY}" | tee /etc/cntlm.conf
else
  echo "No proxy defined!"
  exit 1
fi

echo "Username ${USERNAME}" | tee -a /etc/cntlm.conf
[ "${PASSWORD}" != "UNSET" ] && echo "Password ${PASSWORD}" >> /etc/cntlm.conf && echo "Password -HIDDEN-"

echo "Domain ${DOMAIN}" | tee -a /etc/cntlm.conf
echo "Listen ${LISTEN}" | tee -a /etc/cntlm.conf

[ "${PASSLM}" != "UNSET" ] && echo "PassLM ${PASSLM}" | tee -a /etc/cntlm.conf
[ "${PASSNT}" != "UNSET" ] && echo "PassNT ${PASSNT}" | tee -a /etc/cntlm.conf
[ "${PASSNTLMV2}" != "UNSET" ] && echo "PassNTLMv2 ${PASSNTLMV2}" | tee -a /etc/cntlm.conf
[ "${AUTH}" != "UNSET" ] && echo "Auth ${AUTH}" | tee -a /etc/cntlm.conf
[ "${FLAGS}" != "UNSET" ] && echo "Flags ${FLAGS}" | tee -a /etc/cntlm.conf
[ "${GATEWAY}" != "UNSET" ] && echo "Gateway ${GATEWAY}" | tee -a /etc/cntlm.conf

if [ "${NOPROXY}" != "UNSET" ] ; then
  echo "NoProxy ${NOPROXY}" | tee -a /etc/cntlm.conf
else
  echo "NoProxy localhost, 127.0.0.*, 10.*, 192.168.*" | tee -a /etc/cntlm.conf
fi

# first arg is `-H` or `--some-option`
if [ "${1#-}" != "$1" ]; then
  set -- /usr/sbin/cntlm -c /etc/cntlm.conf "$@"
else
  set -- /usr/sbin/cntlm -c /etc/cntlm.conf -f ${OPTIONS}
fi

exec "$@"
