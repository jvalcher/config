#!/bin/bash

#CPU
top -bn1 | grep load | awk '{printf "cpu-%.1f ", $(NF-2)}'
