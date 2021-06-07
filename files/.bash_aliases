# prompt
PS1="\[\033[1;34m\]\W/ $ \[\033[0m\]"

# add ~/.local/bin to path
export PATH=$PATH:/home/jvalcher/.local/bin

# git graph
alias graph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# easytether
alias easy="sudo easytether-usb"

# search for string in pwd files
alias strS="grep -rnw . -e "
# python
alias py="python3 "




# Change Tmux window title in terminal prompt to "<basepath>/"

# Check if Tmux running with exit status
tmux ls > /dev/null 2>&1
TMUX_STATUS=$?  

# If Tmux running...
if [ $TMUX_STATUS -eq 0 ]; then

    # Change cd functionality to rename window title to 
    # pwd after every directory change
    cd () {

        # use builtin cd to prevent it from calling itself
        builtin cd "$@"
        CD_EXIT_STATUS=$?

        # get pwd, trim to "basepath/", rename window
        getval=$(pwd)
        TMUX_PWD="${getval##*/}/"
        tmux rename-window "$TMUX_PWD"

        # return cd exit status code
        return $CD_EXIT_STATUS
    }

    # Rename window to pwd after vim closes
    vim () {
        /usr/bin/vim "$@"
        cd .
    }

    # Set window title when tmux starts
    cd .

fi
