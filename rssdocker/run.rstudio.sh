#!/usr/bin/with-contenv bash

## load /etc/environment vars first:
for line in $( cat /etc/environment ) ; do export $line ; done
exec /usr/lib/rstudio-server/bin/rserver --server-daemonize 0