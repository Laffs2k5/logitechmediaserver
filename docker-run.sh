#!/bin/bash

docker container rm -f logitechmediaserver_lms_1
docker run \
--name="logitechmediaserver_lms_1" \
-p 3483:3483/tcp \
-p 3483:3483/udp \
-p 9001:9000/tcp \
-p 9090:9090/tcp \
-e PUID="1000" \
-e PGID="1000" \
-v "/etc/timezone":"/etc/timezone":ro \
-v "/etc/localtime":"/etc/localtime":ro \
-v "/opt/logitechmediaserver/config":"/config":rw \
-v "/opt/logitechmediaserver/music":"/music":rw \
-v "/opt/logitechmediaserver/plugins":"/plugins":rw \
-v "/opt/logitechmediaserver/playlists":"/playlists":rw \
logitechmediaserver_lms_1