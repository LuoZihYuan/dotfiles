# dotfile

My personal dotfiles and configuration files

## Contents

This repository contains my personal configuration files for various tools and applications:

- **Starship** (`starship.toml`) - Cross-shell prompt configuration
- **Zsh** (`.zshrc`) - Shell configuration and aliases

## Installation

### Prerequisites

Make sure you have the following installed:
- [Git](https://git-scm.com/)
- [Starship](https://starship.rs/) (optional, for prompt configuration)

### Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/LuoZihYuan/dotfile.git ~/dotfile
   cd ~/dotfile
   ```

2. Create symbolic links to your home directory:
   ```bash
   ln -sf ~/dotfile/.zshrc ~/.zshrc
   ln -sf ~/dotfile/.config/starship.toml ~/.config/starship.toml
   ```

3. Reload your shell configuration:
   ```bash
   source ~/.zshrc
   ```

## Customization

Feel free to fork this repository and customize the configurations to suit your needs.