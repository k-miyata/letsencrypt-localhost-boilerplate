#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ $# -lt 1 ]; then
  echo 'Error: invalid argument'
  echo 'Usage: ./encrypt.sh RECIPIENT'
  exit 1
fi

cd $(dirname ${BASH_SOURCE})

cat backups/certs.tar | age -r $1 > backups/certs.tar.age

rm backups/certs.tar
