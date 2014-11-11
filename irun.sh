#!/bin/bash

sudo docker run -t -i \
	--name=Graphite-Carbon \
	-h graphite-carbon \
	-v $(pwd)/data:/storage \
	-p 80 \
	-p 2003:2003 \
	localhost:5000/graphite-carbon /bin/bash
