
# prompt
PS1="\e[1;34m$ \e[m"

# add ~/.local/bin to path
export PATH=$PATH:/home/jvalcher/.local/bin

# git graph
alias graph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# easytether
alias easy="sudo systemctl restart systemd-networkd && sudo easytether-usb"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# search for string in pwd files
alias strS="grep -rnw . -e "

# python
alias py="python3 "
