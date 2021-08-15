#!/bin/bash

#pact
if [[ $(sudo docker ps -aqf "name=pact") ]]; then
    sudo docker rm -f $(sudo docker ps -aqf "name=pact")
fi
if [[ $(sudo docker images pact -aq) ]]; then
   sudo docker rmi -f $(sudo docker images pact -aq)
fi

