#!/bin/bash

DOCKER_UID=root DOCKER_GID=root docker-compose run --rm --service-ports app bash
exit_code=$?
docker-compose down
exit $exit_code