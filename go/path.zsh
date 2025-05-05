# Source asdf-golang environment variables
if command -v asdf &>/dev/null; then
  if [[ -d "$(asdf where golang 2>/dev/null)" ]]; then

    # Check for linux path
    if [[ -f "$HOME/.asdf/plugins/golang/set-env.zsh" ]]; then
      source "$HOME/.asdf/plugins/golang/set-env.zsh"

    # Check for macOS path
    elif [[ -f "/opt/homebrew/opt/asdf/plugins/golang/set-env.zsh" ]]; then
      source "/opt/homebrew/opt/asdf/plugins/golang/set-env.zsh"
    fi
  fi
fi
