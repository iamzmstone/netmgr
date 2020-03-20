#!/bin/bash
set -e

APP_ROOT=/netmgr
# Remove a potentially pre-existing server.pid for Rails.
rm -f $APP_ROOT/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

