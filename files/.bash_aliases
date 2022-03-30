
# F11 == toggle fullscreen mode

# start tmux
echo $TMUX | grep -q "/tmp"
STATE=$?
if [ $STATE -ne 0 ]; then
    tmux
fi

# prompt
PS1="\[\033[1;38;5;25m\]\W/ $ \[\033[0m\]"

# read man pages with vim
export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

# append to history on every command, don't empty on exit
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
shopt -s histappend

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

# WSL Chrome 
alias chrome="/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"

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

# add ~/include to C header path
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/$USER/include

# mount android via usb
alias android-connect="mtpfs -o allow_other /media/Samsung"
alias android-disconnect="fusermount -u /media/Samsung"

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


LS_COLORS='rs=0:di=01;33:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
