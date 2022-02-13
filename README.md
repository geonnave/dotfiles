# dotfiles
My linux dotfiles.

Clone and run the setup script:
```bash
mkdir -p ~/dev/config/ && cd ~/dev/config/
git clone git@github.com:geonnave/dotfiles.git
cd dotfiles
./setup.sh
```

Enable the vim plugins:
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

# also, if a debian

```
sudo apt install \
  git \
  vim \
  htop \
  guake \
  tmux \
  zsh \
  curl
```

