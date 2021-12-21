#!/bin/bash

# install vim-markdown
MD_DIR="/home/$USER/Downloads/vim-markdown"
printf "\n\n"
printf "Installing vim-markdown...\n" 
echo "________________"
if [ -e $MD_DIR ]; then
    echo "Already installed"
else
    (cd ~/Downloads; \
    git clone https://github.com/plasticboy/vim-markdown.git; \
    cd vim-markdown; \
    sudo make install; \
    vim-addon-manager install markdown)
fi 

