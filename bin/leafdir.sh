#!/usr/bin/env zsh

find $1 -type d -exec sh -c '(ls -p "{}" | grep / > /dev/null) || echo "{}"' \;
