#!/bin/sh

echo "Username ${USERNAME}" | tee /etc/cntlm.conf

if [ "${PASSWORD}" != "UNSET" ] ; then
  echo "Password ${PASSWORD}" >> /etc/cntlm.conf
  echo "Password -HIDDEN-"
fi

echo "Domain ${DOMAIN}" | tee -a /etc/cntlm.conf


if [ "${PROXY}" ] ; then
  echo "Proxy ${PROXY}" | tee -a /etc/cntlm.conf
else
  echo "No proxy defined!"
  exit 1
fi

echo "Listen ${LISTEN}" | tee -a /etc/cntlm.conf

if [ "${PASSLM}" != "UNSET" ] ; then
  echo "PassLM ${PASSLM}" | tee -a /etc/cntlm.conf
fi

if [ "${PASSNT}" != "UNSET" ] ; then
  echo "PassNT ${PASSNT}" | tee -a /etc/cntlm.conf
fi

if [ "${PASSNTLMV2}" != "UNSET" ] ; then
  echo "PassNTLMv2 ${PASSNTLMV2}" | tee -a /etc/cntlm.conf
fi

if [ "${AUTH}" != "UNSET" ] ; then
  echo "Auth ${AUTH}" | tee -a /etc/cntlm.conf
fi

if [ "${FLAGS}" != "UNSET" ] ; then
  echo "Flags ${FLAGS}" | tee -a /etc/cntlm.conf
fi

if [ "${GATEWAY}" != "UNSET" ] ; then
  echo "Gateway ${GATEWAY}" | tee -a /etc/cntlm.conf
fi

if [ "${NOPROXY}" != "UNSET" ] ; then
  echo "NoProxy ${NOPROXY}" | tee -a /etc/cntlm.conf
else
  echo "NoProxy localhost, 127.0.0.*, 10.*, 192.168.*" | tee -a /etc/cntlm.conf
fi

/usr/sbin/cntlm -c /etc/cntlm.conf -f ${OPTIONS}
