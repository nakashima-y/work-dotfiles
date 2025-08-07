#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Homebrew設定（環境自動判定）
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # Apple Silicon
  export PATH="/opt/homebrew/bin:$PATH"
elif [[ -f "/usr/local/bin/brew" ]]; then
  # Intel / Rosetta
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "Warning: Homebrew not found"
fi

# rbenv設定
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Node.js設定（nodebrew）
export PATH=$HOME/.nodebrew/current/bin:$PATH