#!/bin/bash

while getopts p:o: flag
do
    case "${flag}" in
        p) PROJECTNAME=${OPTARG};;
        o) ORG=${OPTARG};;
        *) echo "Usage: $0 [-p projectname] [-o org]" && exit 1;;
    esac
done

IPFSCID=$(npx subql publish -o -f . | awk '/SubQuery Project project.yaml uploaded to IPFS:/ {print $NF}')

npx subql deployment:deploy -d --ipfsCID="$IPFSCID" --projectName="${PROJECTNAME}" --org="${ORG%/*}"