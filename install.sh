#!/bin/bash
DIRNAME=$(dirname $(readlink -f "$0"))

if [ "$#" -eq 0 ]; then
    echo "Использование: ./install.sh [config_1] [config_2] ..."
    echo "Доступные конфиги:"
    echo " [nvim]      -  Neovim"
    echo " [pipewire]  -  Pipewire mono playback"
    echo " [yazi]      -  Yazi"
    echo " [zsh]       -  ZSH + Starship"
    echo " [starship]  -  Starship (w/o shell)"
    exit 0
fi

for config in "$@"; do
    case "$config" in
        nvim)
            echo "Installing NeoVim..."

            sudo pacman -S --noconfirm --needed neovim luarocks

            rm -rf ~/.config/nvim
            ln -sf "$DIRNAME"/nvim ~/.config
        ;;
        pipewire)
            echo "Installing Pipewire..."

            mkdir -p ~/.config/pipewire/pipewire.conf.d
            ln -sf "$DIRNAME"/pipewire/pipewire.conf.d/mono-playback.conf ~/.config/pipewire/pipewire.conf.d
        ;;
        yazi)
            echo "Installing Yazi..."

            sudo pacman -S --noconfirm --needed yazi 7zip mediainfo trash-cli wl-clipboard

            rm -rf ~/.config/yazi
            ln -sf "$DIRNAME"/yazi ~/.config
        ;;
        zsh)
            echo "Installing ZSH..."

            sudo pacman -S zsh starship

            rm -rf ~/.zshrc
            ln -sf "$DIRNAME"/zsh/.zshrc ~/
            ln -sf "$DIRNAME"/zsh/.zsh_plugins.txt ~/
        ;;
        *)
            echo " Unknown Config: $config"
        ;;
    esac
done

echo " Installation Completed"
