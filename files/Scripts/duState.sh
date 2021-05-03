#!/bin/bash

#DU
df -h | awk '$NF=="/"{printf "du-%.1f", $5}'
