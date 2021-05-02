# RAM, CPU, DU output for Tmux status bar

#RAM
free -m | awk 'NR==2{printf "RAM:%.1f ", $3*100/$2 }'
#CPU
top -bn1 | grep load | awk '{printf "CPU:%.1f ", $(NF-2)}'
#DU
df -h | awk '$NF=="/"{printf "DU:%.1f", $5}'
