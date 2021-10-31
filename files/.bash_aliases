
# F11 == toggle fullscreen mode

# start tmux
echo $TMUX | grep -q "/tmp"
STATE=$?
if [ $STATE -ne 0 ]; then
    tmux
fi

# prompt
PS1="\[\033[1;33m\]\W/ $ \[\033[0m\]"

# add bins to path
export PATH=$PATH:/home/$USER/.local/bin
export PATH=$PATH:/home/$USER/bin

# git graph
alias graph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# connect to easytether via usb
alias easy="sudo easytether-usb"

# reset networkd if easytether won't connect
alias reeasy="sudo systemctl restart systemd-networkd"

# activate/refresh asusBox hotspot
alias hotup="nmcli connection down Hotspot 2>/dev/null; nmcli connection up Hotspot"
# take down hotspot
alias hotdown="nmcli connection down Hotspot"

# chrome alias
alias chrome="google-chrome"

# search for string recursively in pwd
alias strS="grep -rnw . -e "

# search for file recursively in pwd
alias fileS="find . -name "

# python
alias py="python3 "

# pip
alias pip3="pip"

# activate cursor selection for windows to get PID
alias winSel="xprop _NET_WM_PID | sed 's/_NET_WM_PID(CARDINAL) = //' | ps 'cat'"

# copy pwd to clipboard
alias pclip="pwd | xclip -sel clip"

# kill all tmux sessions 
alias tkill="tmux kill-server"

# play singing_bowl sound 
alias bowl="aplay ~/Music/singing_bowl.wav"

# reset ll set in .bashrc -> vertical file list, no info
llr () {

    # if no files in directory, return prompt
    if [ -z "$(ls $1)" ]; then
        printf ""
    # otherwise
    else
        # no dir argument
        if [ $# -eq 0 ]; then
            printf "\n$(ls -1 -p --color=always | sed 's/^/    /')\n\n"
        # with dir argument
        else
            printf "\n$(ls -1 -p --color=always $1 | sed 's/^/    /')\n\n"
        fi
    fi
}
alias ll="llr"


# remap "la" alias to list just hidden files
lla () {

    # Exit codes with/without argument are 0 if 
    # no hidden files present
    STATE=$(ls -1d .!(|.) |& grep -q "No such file"; echo $?)
    STATE_ARGS=$(cd $1; ls -1d .!(|.) |& grep -q "No such file"; echo $?)

    # If no argument
    if [ $# -eq 0 ]; then
        if [ $STATE -eq 0 ]; then
            printf ""
        else
            printf "\n$(ls -1dp --color=always .!(|.) | sed 's/^/    /')\n\n"
        fi
    # If argument
    else
        if [ $STATE_ARGS -eq 0 ]; then
            printf ""
        else
            printf "\n$(cd $1; ls -1dp --color=always .!(|.) | sed 's/^/    /')\n\n"
        fi
    fi
}
alias la="lla"

# git status and file sizes
gitstat () {
    printf "\n"
    git status 
    printf "\n"
    git status-size
    printf "\n"
}

# compiles file.c as file, runs it, prints file name
gco () {
    FILE="$1"
    OUTPUT_FILE="${FILE%.*}"
    gcc -o $OUTPUT_FILE $FILE
    #printf "\n\e[1;32mOutput:\e[0m\n"
    #printf "\e[1;32m_ _ _ _ _ _ _ _ _ _ _ _ _ _ _\e[0m\n\n"
    printf "\n"
    ./"$OUTPUT_FILE"
    printf "\n"
    #printf "\n\e[1;32m_ _ _ _ _ _ _ _ _ _ _ _ _ _ _\e[0m\n"
    #printf "\e[1;32mEnd output\n\n"
    #printf "\e[1;32mExecutable:\e[0m  $OUTPUT_FILE\n\n"
}

# compiles, runs, deletes output file after running
gcd () {
    FILE="$1"
    OUTPUT_FILE="${FILE%.*}"
    gcc -o $OUTPUT_FILE $FILE
    printf "\n"
    ./"$OUTPUT_FILE"
    printf "\n"
    rm $OUTPUT_FILE
}

# compile file.cpp as file, run it, delete compiled file
c () {
    FILE="$1"
    OUTPUT_FILE="${FILE%.*}"

    function trap_ctrlc () {
        rm "$OUTPUT_FILE"
        exit 2
    }

    printf "\n-------------\n$FILE -> $OUTPUT_FILE\n-------------\n"
    g++ -Wall -o $OUTPUT_FILE $FILE
    trap "trap_ctrlc" 2

    printf "\n"
    ./"$OUTPUT_FILE" 2>/dev/null
    printf "\n"
    rm "$OUTPUT_FILE" 2>/dev/null
}

# compile file.cpp as file, run it
cop () {
    FILE="$1"
    OUTPUT_FILE="${FILE%.*}"
    g++ -o $OUTPUT_FILE $FILE
    printf "\n"
    ./"$OUTPUT_FILE"
    printf "\n"
}

# clear all compiled C files in pwd (i.e. files not ending in '.c')
clearC () {
    find . -type f ! -name "*.c" -delete
}

# Change Tmux window title in terminal prompt to "<basepath>/"
# If Tmux running...
tmux ls > /dev/null 2>&1
TMUX_STATUS=$?
if [ $TMUX_STATUS -eq 0 ]; then
    # Create function to get pwd, trim to "basepath/", 
    # and rename window
    basepathTitle () {
        getval=$(pwd)
        BASEPATH_TITLE=" ${getval##*/}/ "
        tmux rename-window "${BASEPATH_TITLE:0:12}"
        #tmux rename-window "$BASEPATH_TITLE"
    }
    # Change cd functionality to rename window title to
    # pwd after every directory change
    cd () {
        builtin cd "$@"
        CD_STATUS=$?
        basepathTitle
        return "$CD_STATUS"
    }
    # Change vim functionality to change title 
    # back to basepath on close
    # Start, save title controlled in .vimrc
    vim () {
        
        FILE_NAME=$@
        tmux rename-window "${FILE_NAME:0:12}"
        /usr/bin/vim "$FILE_NAME"
        VIM_STATUS=$?
        return "$VIM_STATUS"
    }
    # Set window title when tmux starts
    basepathTitle
fi

# countdown timer   (ex: countdown 00:10:00)
countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  echo
)

## Open notes file in current practice directory
#learn () {
#    PRACTICE_DIR="/home/$USER/Git/practice/c/c_modern_approach_2e"
#    NOTES_FILE="notes.c"
#    cd $PRACTICE_DIR && vim '+ normal Gzz' notes.c
#    tmux new-window -d -t 10
#    tmux send-keys -t 10 "cd $PRACTICE_DIR" Enter
#    tmux send-keys -t 10 "vim $NOTES_FILE" Enter
#    tmux send-keys -t 10 "G" Enter
#    tmux send-keys -t 10 "zz" Enter
#    tmux select-window -t 10
#    SESSION="learnc"
#    tmux kill-session -t $SESSION
#    tmux new-session -d -s $SESSION
#    tmux split-window -h -t $SESSION:1.1
#    tmux split-window -v -p 40 -t $SESSION:1.2
#    tmux send-keys -t $SESSION:1.3 "cd $PRACTICE_DIR && clear && ll" Enter
#    tmux attach-session -t $SESSION
#}


# laundry wash timer
laundry () {
    countdown 01:00:00
    bowl
}
