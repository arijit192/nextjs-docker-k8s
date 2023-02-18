#!/bin/sh

inject () {
    grep -n "#ARGS" Dockerfile | sed 's/:#ARGS//g' | while read -r line; do sed -i $((line+2))"i ARG $1" Dockerfile; done
}
cat ./k8s/config-map.yml | grep "BUILD_ENV_" | sed 's/ //g' | sed 's/BUILD_ENV_//' | sed 's/:/=/' | while read -r val; do inject $val; done