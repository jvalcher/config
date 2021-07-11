#!/bin/bash

# prompt
PS1="\[\033[1;33m\]\W/ $ \[\033[0m\]"

# add ~/.local/bin to path
export PATH=$PATH:/home/$USER/.local/bin
export PATH=$PATH:/home/$USER/bin


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

# compiles file.c as file, runs it, prints file name
gco () {
    FILE="$1"
    OUTPUT_FILE="${FILE%.*}"
    gcc -o $OUTPUT_FILE $FILE
    printf "\n\e[1;32mOutput:\e[0m\n"
    printf "\e[1;32m_ _ _ _ _ _ _ _ _ _ _ _ _ _ _\e[0m\n\n"
    ./"$OUTPUT_FILE"
    printf "\n\e[1;32m_ _ _ _ _ _ _ _ _ _ _ _ _ _ _\e[0m\n\n"
    printf "\e[1;32mExecutable:\e[0m  $OUTPUT_FILE\n\n"
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
    # basepathTitle

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

## ls, returns only hidden files
## no formatting, less enabled
#lsa () {
#
#    # Exit codes with/without argument are 0 if no hidden files present
#    EXIT=$(ls -1d .!(|.) |& grep -q "No such file"; echo $?)
#    EXIT_ARG=$(cd $1; ls -1d .!(|.) |& grep -q "No such file"; echo $?)
#
#    # If no argument
#    if [ $# -eq 0 ]; then
#        if [ $EXIT -eq 0 ]; then
#            printf ""
#        else
#            ls -1dp .!(|.)
#        fi
#    # If argument
#    else
#        if [ $EXIT_ARG -eq 0 ]; then
#            printf ""
#        else
#            (cd $1; ls -1dp .!(|.))
#        fi
#    fi
#}
