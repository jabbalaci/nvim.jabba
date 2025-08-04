# Jabba's nvim config

This repo contains my Neovim configuration.

I took the [Kickstart project](https://github.com/nvim-lua/kickstart.nvim)
and customized it to my needs.

## Installation

```shell
$ cd ~/.config
$ mkdir nvim.jabba
$ cd nvim.jabba
$ git clone https://github.com/jabbalaci/nvim.jabba .
```

Then, if you use fish shell, you can add these lines to your fish config:

```fish
set -gx NVIM_APPNAME nvim.jabba
set -gx EDITOR nvim
set -gx VIEWER $EDITOR
set -gx VISUAL $EDITOR
set -gx GIT_EDITOR $EDITOR

alias vim nvim
abbr nv "nvim -u NORC"  # vanilla version (no config file, no plugins)
```
