#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ $# -lt 1 ]; then
  echo 'Error: invalid argument'
  echo 'Usage: ./decrypt.sh PATH_TO_KEY'
  exit 1
fi

cd $(dirname ${BASH_SOURCE})

cat backups/certs.tar.age | age --decrypt -i $1 > backups/certs.tar
