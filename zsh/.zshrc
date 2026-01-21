#---[ Preferences ]--------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY


#---[ Aliases ]------------------------------------------------------
# Replacements
calias() { if (( ${+commands[${2%% *}]} )); then alias $1=$2; fi }
calias cat "bat"

# NeoVim
alias n="nvim"
alias sn="sudo -Es nvim"

# Global
alias -g zc="~/.zshrc"
alias -g zp="~/.zsh_plugins.txt"

# Abbreviations
alias ..="cd .."
alias -g G="| grep"


#---[ Binds ]--------------------------------------------------------
bindkey "^H" backward-kill-word


#---[ Plugin Configuration ]-----------------------------------------
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':fzf-tab:*' fzf-flags\
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4


#---[ Yazi ]---------------------------------------------------------
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


#---[ Antidote ]-----------------------------------------------------
ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"

if [[ ! -d "$ANTIDOTE_DIR" ]]; then
    echo "Installing Antidote..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
fi

source "$ANTIDOTE_DIR/antidote.zsh"
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt


#---[ Starship ]-----------------------------------------------------
(( ${+commands[starship]} )) && eval "$(starship init zsh)"
