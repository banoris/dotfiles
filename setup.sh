cd $HOME
[[ -f .bashrc ]]    && mv .bashrc .bashrc.bak; ln -sf dotfiles/.bashrc ./
[[ -f .vimrc ]]     && mv .vimrc .vimrc.bak; ln -sf dotfiles/.vimrc ./
[[ -f .inputrc ]]   && mv .inputrc .inputrc.bak; ln -sf dotfiles/.inputrc ./
[[ -f .gitconfig ]] && mv .gitconfig .gitconfig.bak; ln -sf dotfiles/.gitconfig ./
[[ -f .screenrc ]]  && mv .screenrc .screenrc.bak; ln -sf dotfiles/.screenrc ./
[[ -f .gdbinit ]]   && mv .gdbinit .gdbinit.bak; ln -sf dotfiles/.gdbinit ./
[[ -f .vim ]]       && mv .vim .vim.bak; ln -sf dotfiles/.vim ./
[[ -f .seascope ]]  && mv .seascope .seascope.bak; ln -sf dotfiles/.seascope ./
