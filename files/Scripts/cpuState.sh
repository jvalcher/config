# RAM, CPU, DU output for Tmux status bar

#!/bin/bash

#RAM
free -m | awk 'NR==2{printf "ram-%.1f ", $3*100/$2 }'
#CPU
top -bn1 | grep load | awk '{printf "cpu-%.1f ", $(NF-2)}'
#DU
df -h | awk '$NF=="/"{printf "du-%.1f", $5}'
