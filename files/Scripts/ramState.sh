#!/bin/bash

#RAM
free -m | awk 'NR==2{printf "ram-%.1f ", $3*100/$2 }'

