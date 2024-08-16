#!/bin/bash

# The section to define script's vars
# enter here the same name as for start.sh script
network_name=normal01

# to stop all the containers
# they are started with --rm, we don't need to remove it
docker stop $(docker ps -a -q)

# to remove the app's network
docker network rm $network_name

