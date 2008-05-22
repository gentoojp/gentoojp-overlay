#!/bin/sh

TIARRADIR="${TIARRADIR:-$HOME/.tiarra}"

cd "${TIARRADIR}"

exec /usr/lib/tiarra/tiarra "$@"
