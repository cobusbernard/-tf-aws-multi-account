#!/bin/bash
set -e

ENVIRONMENT=$1

DIR_ABS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SYSTEM=$(basename $DIR_ABS)

if [ ! -f _$ENVIRONMENT/proposed.plan ]; then
    echo "The planning file was not found. Please first run 'plan.sh' to generate a plan to apply."
    exit 1
fi

if [ -z $ENVIRONMENT ]; then
  echo "No environment set. Please use 'master'"
  exit 1
fi

if [ "$ENVIRONMENT" != master ] ; then
     echo "Incorrect value for environment. Please use 'master'."
     exit 1
fi

echo "Preparing to apply:"
echo "==================="
echo "System: ${SYSTEM}"
echo "Environment: _$ENVIRONMENT"

terraform apply \
  _$ENVIRONMENT/proposed.plan

rm _$ENVIRONMENT/proposed.plan
