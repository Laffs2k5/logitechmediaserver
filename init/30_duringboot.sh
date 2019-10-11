#!/bin/bash
#
# 30_duringboot.sh
#

# Create dirs
# Make sure the "squeezeboxserver" script will not create them with 'root' ownership later

# Create prefs directory if it doesn't exist
if [ ! -d /config/prefs ]; then
	mkdir /config/prefs
	mkdir /config/prefs/plugin
fi

# Create prefs plugin directory if it doesn't exist
if [ ! -d /config/prefs/plugin ]; then
	mkdir /config/prefs/plugin
fi

# Create logs directory if it doesn't exist
if [ ! -d /config/logs ]; then
	mkdir /config/logs
fi

touch /config/logs/perfmon.log
touch /config/logs/server.log

# Create cache directory if it doesn't exist
if [ ! -d /config/cache ]; then
	mkdir /config/cache
fi

# Create misc directories if it doesn't exist
if [ ! -d /config/cache/audioUploads ]; then
	mkdir /config/cache/audioUploads
fi
if [ ! -d /config/cache/InstalledPlugins ]; then
	mkdir /config/cache/InstalledPlugins
fi
if [ ! -d /config/cache/DownloadedPlugins ]; then
	mkdir /config/cache/DownloadedPlugins
fi
if [ ! -d /config/cache/updates ]; then
	mkdir /config/cache/updates
fi

# create a "docker" user
useradd -U docker

# Configure user docker user
usermod -aG audio docker
chown -R docker:docker /config
chmod -R go+rw /config
chown docker:docker \
	/music \
	/plugins \
	/playlists