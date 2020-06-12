#!/bin/bash

# This script performs a GET request on a URL every .5 seconds.
# E.g: run.sh http://localhost:3000/health-check/

URL=$1

if [ -z "$URL" ]; then
    URL="<YOUR_DEFAULT_URL>"
fi

while true; do curl $URL
sleep .5;
done;
