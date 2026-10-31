# ==========================================
# Shawn's Zsh Configuration
# ==========================================

# 1. Homebrew 環境初始化 (相容 Apple Silicon & Intel Mac)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export PATH="$HOME/.local/bin:$PATH"

# 2. Zsh 原生自動補全設定
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 3. 智慧目錄跳轉 (zoxide)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# 4. 模糊搜尋器 (fzf，支援 zi 互動與 Ctrl+R 歷史搜尋)
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# 5. eza (取代 ls，提供圖示與色彩)
if command -v eza &>/dev/null; then
  alias ls="eza --icons"
  alias ll="eza -lh --icons --git"
  alias la="eza -lah --icons --git"
  alias tree="eza --tree --icons"
fi

# 6. 多層目錄快速跳轉 (支援 cd ... 或直接輸入 ...)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# 7. 歷史指令灰字自動建議 (zsh-autosuggestions)
if [[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 8. Starship 提示符
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# 9. 即時語法高亮 (zsh-syntax-highlighting，依官方規範需置於最末尾)
if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
