#!/bin/bash

if [ -f "/.firstboot" ]; then
	echo "First boot!"

	mkdir -p /storage/graphite /storage/graphite/whisper /storage/graphite/rrd

	cd /usr/local/src/graphite-web
	python ./setup.py install

	cd /usr/local/src/whisper
	python ./setup.py install

	cd /usr/local/src/carbon
	python ./setup.py install

	/usr/local/bin/django_admin_init.exp

	rm /.firstboot
fi

exec supervisord -n
