# dotnvim

## Introduction

A Neovim config based on [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)

## Installation

### Install Neovim

This config targets _only_ [`0.10.0^`](https://github.com/neovim/neovim/releases/tag/v0.10.4) of Neovim, and support _only_ Debian and MacOS.
If you are experiencing issues, please make sure you have the correct version.

### Install this config

> [!NOTE] > [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations is located at `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim`

#### Globally install

Clone this repo to the configuration path.

```sh
git clone https://github.com/vex9z7/dotnvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

#### Parallel install

You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME` to maintain multiple configurations.

Clone this repo to `XDG_CONFIG_HOME`.

```sh
git clone https://github.com/vex9z7/dotnvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/dotnvim

```

Create an alias:

```
alias dotnvim='NVIM_APPNAME="dotnvim" nvim'
```

When you run Neovim using `dotnvim` alias it will use the alternative
config directory and the matching local directory
`~/.local/share/dotnvim`.

You can apply this approach to any Neovim
distribution that you would like to try out.

### Install External Dependencies

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

#### Debian

<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

</details>

<!--#### MacOS-->
<!---->
<!--Underconstruction-->

### FAQ

- What should I do if I already have a pre-existing Neovim configuration?

  - You should back it up and then delete all associated files.
  - This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`

- What if I want to "uninstall" this configuration:

  - See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information

- What is the idea of kickstart-modular structure?
  - See [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218) and [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)
