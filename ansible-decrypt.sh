#!/usr/bin/env bash

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0

ANSIBLE_PASS="~/.ansible.vault.pass"
ANSIBLE_LOG="/tmp/ansible_decrypt.log"
CHECK_COMMAND=$(command -v yq | wc -l)

if [[ $CHECK_COMMAND == 0 ]] ; then
  echo "[ERROR] yq command does not exist!"
  echo "Install here: https://github.com/mikefarah/yq"
  exit 1
fi

if [[ -n $1 ]] ; then
  egrep '\!vault \|' $1 | awk -F':' '{print $1}' | sort > /tmp/ansible_decrypt.log
  rm -f /tmp/ansible_decrypt.stdout

  for VARIABLES in $(cat /tmp/ansible_decrypt.log) ; do
    echo -ne "$VARIABLES: " ; yq read $1 $VARIABLES | ansible-vault decrypt 2>/dev/null
    echo
  done >> /tmp/ansible_decrypt.stdout
  cat /tmp/ansible_decrypt.stdout | column -t
elif [[ -z $1 ]] ; then
  egrep -rnw '\!vault \|' . | awk -F':' '{print $1}' | uniq -d | sort > /tmp/ansible_decrypt.log
  for files in $(cat /tmp/ansible_decrypt.log) ; do
    rm -f /tmp/ansible_decrypt.stdout
    echo "  ||-----> $files"
    for VARIABLES in `cat $files | egrep '\!vault \|' | awk -F':' '{print $1}'` ; do
      paste -d"\t" <(echo "$VARIABLES: ") <(yq read $files $VARIABLES | ansible-vault decrypt 2>/dev/null) >> /tmp/ansible_decrypt.stdout
    done
    cat /tmp/ansible_decrypt.stdout | column -t
    printf '\n\n'
  done
fi

rm -f /tmp/ansible_decrypt*