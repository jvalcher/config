
# prompt
PS1="\e[1;34m\W/ $ \e[m"

# add ~/.local/bin to path
export PATH=$PATH:/home/jvalcher/.local/bin

# git graph
alias graph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# easytether
alias easy="sudo easytether-usb"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# search for string in pwd files
alias strS="grep -rnw . -e "

# python
alias py="python3 "

# auto set tab name
function tab_title {
  if [ -z "$1" ]
  then
    title="${PWD##*/}/" # current directory
  else
    title=$1 # first param
  fi
  echo -n -e "\033]0;$title\007"
}
cd() { builtin cd "$@" && tab_title; }
pushd() { builtin pushd "$@" && tab_title; }
popd() { builtin popd "$@" && tab_title; }
tab_title
