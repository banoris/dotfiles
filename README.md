# dotfiles
My dotfiles


## Misc stuff

* Vim ssh slow startup (~2s) due to Xserver clipboard -- `vim -X` (disable xclipboard) or use `nvim` with `xclip` as clipboard backend. `nvim` loads backend asynchronously.

Step to add new vim plugin as submodule:

```
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
