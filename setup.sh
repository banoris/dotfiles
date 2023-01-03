#!/usr/bin/env bash

# set -Eeuo pipefail
# trap cleanup SIGINT SIGTERM ERR EXIT

cd $HOME
[[ -f .bashrc ]]    && mv .bashrc .bashrc.bak; ln -sf dotfiles/.bashrc ./
[[ -f .vimrc ]]     && mv .vimrc .vimrc.bak; ln -sf dotfiles/.vimrc ./
[[ -f .inputrc ]]   && mv .inputrc .inputrc.bak; ln -sf dotfiles/.inputrc ./
[[ -f .gitconfig ]] && mv .gitconfig .gitconfig.bak; ln -sf dotfiles/.gitconfig ./
[[ -f .screenrc ]]  && mv .screenrc .screenrc.bak; ln -sf dotfiles/.screenrc ./
[[ -f .gdbinit ]]   && mv .gdbinit .gdbinit.bak; ln -sf dotfiles/.gdbinit ./
[[ -f .vim ]]       && mv .vim .vim.bak; ln -sf dotfiles/.vim ./
[[ -f .seascope ]]  && mv .seascope .seascope.bak; ln -sf dotfiles/.seascope ./
[[ -f .bash_tmux_completion ]]  && mv .bash_tmux_completion .bash_tmux_completion.bak; ln -sf dotfiles/.bash_tmux_completion ./
# setup xterm font and font size
[[ -f .Xresources ]]  && mv .Xresources  .Xresources.bak; ln -sf dotfiles/.Xresources  ./

# custom binaries
ln -sf ~/dotfiles/bin-amd64 ~/.local/

# setup grc
# echo "===== Setup grc ====="
# [[ -d ~/.grc ]] && mv .grc .grc.bak
# [[ ! -d ~/.grc ]] && mkdir ~/.grc
# [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
# cd $HOME/dotfiles/modules/grc/
# cp grc grcat ~/.local/bin/    # cp executables
# cp colourfiles/conf.* ~/.grc/ # cp tools' conf files
# cp grc.conf ~/.grc/           # grcat conf files
# cp grc.bashrc ~/.grc/    # setup auto alias for bash

echo DONE
