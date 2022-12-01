# dotfiles
My dotfiles


## Misc stuff

* Vim ssh slow startup (~2s) due to Xserver clipboard -- `vim -X` (disable xclipboard) or use `nvim` with `xclip` as clipboard backend. `nvim` loads backend asynchronously.

Step to add new vim plugin as submodule:
```sh
cd .vim/pack/banoris/start/
git clone https://github.com/luochen1990/rainbow.git

# Try it out first... and if you like it, add as submodule
git submodule add <url> .vim/pack/...
git submodule add https://github.com/luochen1990/rainbow.git .vim/pack/banoris/start/rainbow/

# clone a repo and its submodules
git clone --recurse-submodules <url>

# Or if you already cloned and forgot the --recurse-submodules flag
git submodule update --init --recursive
```

## Cheatsheet
```sh
# list all group
getent group

# Install latest-n-greatest vim to ~/.local/bin
git clone https://github.com/vim/vim.git && cd vim && ./configure --prefix=$HOME/.local && make && make install

```

## gnome-terminal

Change prev/next tab hotkey to to Ctrl-Tab, Ctrl-Shift-Tab, common hotkey in tabbed interface. Refer https://askubuntu.com/questions/133384/keyboard-shortcut-gnome-terminal-ctrl-tab-and-ctrl-shift-tab-in-12-04
```
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'
```
