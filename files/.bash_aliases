
# F11 == toggle fullscreen mode

# start tmux
echo $TMUX | grep -q "/tmp"
STATE=$?
if [ $STATE -ne 0 ]; then
    tmux
fi

# prompt
PS1="\[\033[1;38;5;25m\]\W/ $ \[\033[0m\]"

# add bins to path
export PATH=$PATH:/home/$USER/.local/bin
export PATH=$PATH:/home/$USER/bin

# read man pages with vim
export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"

# man to vman (vim-superman)
alias vman="man"

# connect to easytether via usb
alias easy="sudo systemctl restart systemd-networkd; sudo easytether-usb"

# rm to trash
alias rm="trash-put"

# python
alias py="python3 "

# pip
alias pip3="pip"

# activate cursor selection for windows to get PID
alias winSel="xprop _NET_WM_PID | sed 's/_NET_WM_PID(CARDINAL) = //' | ps 'cat'"

# copy pwd to clipboard
alias pclip="pwd | xclip -sel clip"

# play singing_bowl sound 
alias bowl="(aplay -q ~/Music/singing_bowl.wav > /dev/null 2>&1 &)"

# add autocomplete for markdown files when using google-chrome
complete -f -X '!*.md' google-chrome

# turn highlight pasted text off
bind 'set enable-bracketed-paste off'

# return actual instead of soft link address
alias pwd="pwd -P"

# git graph
alias gitGraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# git status and file sizes
gitStat () {
    printf "\n"
    git status 
    printf "\n"
    git status-size
    printf "\n"
}

# reset ll set in .bashrc to vertical, tabbed file list, no info
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

# change cd and vim functionality to automatically rename tmux windows and panes
CHAR_LIMIT=20
MY_VIM="/usr/bin/vim.gtk3"

tmux ls > /dev/null 2>&1
TMUX_STATUS=$?
if [ $TMUX_STATUS -eq 0 ]; then

    basedirRename () {

        getval=$(pwd)
        BASEPATH_FULL="${getval##*/}"
        BASEPATH="${BASEPATH_FULL:0:$CHAR_LIMIT}/"

        tmux rename-window " $BASEPATH "
        tmux select-pane -T " $BASEPATH "
    }
    fileRename () {

        FILENAME_FULL="$@"
        FILENAME="${FILENAME_FULL:0:$CHAR_LIMIT}"
        tmux rename-window " $FILENAME "
        tmux select-pane -T " $FILENAME "
    }

    cd () {
        builtin cd "$@"
        CD_STATUS=$?
        basedirRename
        ll
        return "$CD_STATUS"
    }

    vim () {

        # if no argument, open NERDTree
        if [ -z "$1" ]
        then
            vim -c "NERDTreeToggle"
            VIM_STATUS="$?"
        else
            fileRename $@
            $MY_VIM $@
            VIM_STATUS="$?"
        fi

        basedirRename
        return "$VIM_STATUS"
    }

    basedirRename
fi

# countdown timer   (ctd 00:10:00)
ctd()
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
  bowl
)


