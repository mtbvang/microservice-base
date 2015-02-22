#!/bin/sh

# TODO: use proper config file!
SERVICEFILE=./service-info.txt

NAMESPACE=$(sed '2q;d' $SERVICEFILE)
IMAGENAME=$NAMESPACE/$(sed '4q;d' $SERVICEFILE)
FOLDER=$(sed '8q;d' $SERVICEFILE)

COMMAND=$1

if [ -z "$1" ]
  then
    COMMAND="/bin/bash"
    echo "Usage  ./docker-run COMMAND\n"
    echo "No COMMAND provided, defaulting to '/bin/bash'\n"
fi

if [ -z "$FOLDER" ]
  then
    echo "Running: docker run --rm -it -P --entrypoint="$COMMAND" $IMAGENAME"
    docker run --rm -it -P --entrypoint="$COMMAND" $IMAGENAME
  else
    echo "Running: docker run --rm -it -P -v $FOLDER:/mnt/host --entrypoint="$COMMAND" $IMAGENAME"
    docker run --rm -it -P -v $FOLDER:/mnt/host --entrypoint="$COMMAND" $IMAGENAME
fi
