#!/usr/bin/env sh

cat $@ \
| tail -n +21 \
| split -l 3
