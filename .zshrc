############################################################
# Environment Variables
############################################################
export GPG_TTY=$(tty)


############################################################
# Aliases
############################################################
alias rm="rm -i"   # Safer remove: ask before deleting


############################################################
# Completion (case-insensitive, cached, custom fpath)
############################################################
# Keep fpath unique and prepend your custom completion dirs if they exist.
typeset -U fpath
for _dir in "$HOME/.docker/completions" "$HOME/.zfunc" "$HOME/Developer/Tools"; do
  [[ -d "$_dir" ]] && fpath=($_dir $fpath)
done
unset _dir

# Initialize completion with caching
autoload -Uz compinit
# Optional: use a dedicated cache path (improves speed)
: "${ZSH_COMPLETION_CACHE:=$HOME/.zcompcache}"
mkdir -p "$ZSH_COMPLETION_CACHE"
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH_COMPLETION_CACHE"

# Case-insensitive matching for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Conda plugin completion preferences
zstyle ':conda_zsh_completion:*' use-groups true
zstyle ':conda_zsh_completion:*' show-unnamed true
zstyle ':conda_zsh_completion:*' sort-envs-by-time true
zstyle ':conda_zsh_completion:*' show-global-envs-first true

# Initialize completion system (ignore insecure dir warnings)
compinit -i


############################################################
# Prompt: Starship
############################################################
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi


############################################################
# Python
############################################################
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if [[ -d "$PYENV_ROOT/bin" ]]; then
  typeset -U path
  path=("$PYENV_ROOT/bin" $path)
fi

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
  if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# uv
if command -v uv >/dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

# conda (managed by `conda init` — left intact)
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


############################################################
# Node.js
############################################################
# nvm (Homebrew)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# pnpm completion
[[ -r "$HOME/completion-for-pnpm.zsh" ]] && source "$HOME/completion-for-pnpm.zsh"


############################################################
# PATH additions
############################################################
typeset -U path

# OpenJDK from Homebrew
if [[ -d "/opt/homebrew/opt/openjdk/bin" ]]; then
  path=("/opt/homebrew/opt/openjdk/bin" $path)
fi

# libpq from Homebrew
if [[ -d "/opt/homebrew/opt/libpq/bin" ]]; then
  path=("/opt/homebrew/opt/libpq/bin" $path)
fi

# mysql-client from Homebrew
if [[ -d "/opt/homebrew/opt/mysql-client/bin" ]]; then
  path=("/opt/homebrew/opt/mysql-client/bin" $path)
fi

# Go bin (respects GOBIN, else GOPATH/bin)
if command -v go >/dev/null 2>&1; then
  _gobin="$(go env GOBIN)"
  [[ -z "$_gobin" ]] && _gobin="$(go env GOPATH)/bin"
  [[ -d "$_gobin" ]] && path=("$_gobin" $path)
  unset _gobin
fi