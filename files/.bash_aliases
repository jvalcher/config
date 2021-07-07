#!/bin/bash

# prompt
PS1="\[\033[1;33m\]\W/ $ \[\033[0m\]"

# add ~/.local/bin to path
export PATH=$PATH:/home/$USER/.local/bin
export PATH=$PATH:/home/$USER/bin


# ll -> vertical file list, no info
function llr () {

    if [ $# -eq 0 ]
    then
        printf "\n$(ls -1 --color=always| sed 's/^/    /')\n\n"

    else
        printf "\n$(ls -1 --color=always $1 | sed 's/^/    /')\n\n"
    fi
}
alias ll="llr"


# git graph
alias graph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# easytether
alias easy="sudo easytether-usb"

# search for string in pwd files
alias strS="grep -rnw . -e "

# python
alias py="python3 "

# pip
alias pip3="pip"

# activate cursor selection for windows to get PID
alias winSel="xprop _NET_WM_PID | sed 's/_NET_WM_PID(CARDINAL) = //' | ps 'cat'"

# copy pwd to clipboard
alias pclip="pwd | xclip -sel clip"

# outputs .c filename as program name without .c
function gco () {
    FILE="$1"
    OUTPUT_FILE="${FILE%.*}"
    gcc -o $OUTPUT_FILE $FILE
    printf "\n    Output file:  $OUTPUT_FILE\n\n"
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
        tmux rename-window "$BASEPATH_TITLE"
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
    vim () {
        
        /usr/bin/vim "$@"
        VIM_STATUS=$?
        
        basepathTitle

        return "$VIM_STATUS"
    }

    # Set window title when tmux starts
    basepathTitle

fi

