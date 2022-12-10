#!/bin/bash

$__namedImage="item-app:v1"

docker build -t $__namedImage --file Dockerfile .

docker images --all | awk '{ print $1 " / "  $2 }' | grep "item-*

docker tag $__namedImage $__usernameDockerHub/$__namedImage

echo "$__passwordDockerHub" | docker login --username $__usernameDockerHub --password-stdin

docker push $__usernameDockerHub/$__namedImage

