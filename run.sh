#!/bin/bash

sudo docker run -t -d \
	--name=Graphite-Carbon \
	-h graphite \
	-p 80 \
	-p 2003:2003 \
	-v $(pwd)/data:/storage \
	localhost:5000/graphite-carbon
