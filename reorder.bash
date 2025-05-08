#!/usr/bin/env bash
set -x
while [[ -n $2 ]]; do
  jj rebase -r "$2" -d "$1"
  shift 1
done
