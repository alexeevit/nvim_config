# My Neovim config files

## Installation

### Install dependencies
```
# Ubuntu
sudo apt install python3

# Fedora
sudo yum install python3
```

### Install python dependencies

```
pip3 install pynvim send2trash
```

### Install plugin manager
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Clone the config
```
rm -rf ~/.config/nvim
git clone git@github.com:alexeevit/nvim_config.git ~/.config/nvim
```

### Install plugins

Open nvim and run
```
:PlugInstall
```

### ??? PROFIT
