# Logitech Media Server

Docker image for Logitech Media Server (SqueezeCenter, SqueezeboxServer, SlimServer)

The Docker updates the system on restart to apply security and Linux updates.

To run LMS on unRAID:

docker run -d \
-p 3483:3483/tcp \
-p 3483:3483/udp \
-p 9000:9000/tcp \
-p 9090:9090/tcp \
-e PUID="999" \
-e GUID="1000" \
-v "/mnt/user/appdata/LogitechMediaServer":"/config":rw \
-v "/mnt/user/Music":"/music":rw \
-v "/mnt/user/Plugins":"/plugins":rw \
codechimporg/unraid-dockers-logitechmediaserver

Changes:

2018-11-11
- Added plugin volume to allow easy manual deploy of plugins

2017-09-25
- Added pv (pipeview) required for latest Spotty.

2017-09-24
- Modifications to dockerfile for auto build.

2017-07-12
- Add perl OpenSSL packages.

2017-07-11
- Add OpenSSL package.

2017-07-09
- Add perl packages for IO::Socket::SSL.

2017-05-19
- Fix time zone.

2017-05-12
- Update 7.9.1 to latest.

2017-05-07
- Upgrade LMS to 7.9.1.
- Some organizational changes.

2017-04-23
- Organization and code cleanup.

2017-04-22
- Added PUID and PGID for proper appdata ownership settings for unRAID.
