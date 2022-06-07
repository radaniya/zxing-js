#!/bin/bash

DOCKER_UID=pn DOCKER_GID=pn docker-compose run --rm --service-ports app bash
exit_code=$?
docker-compose down
exit $exit_code