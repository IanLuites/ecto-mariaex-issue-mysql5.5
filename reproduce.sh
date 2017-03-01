#!/bin/bash -e

docker build -t mariex-issue-5.5 .
docker run mariex-issue-5.5
