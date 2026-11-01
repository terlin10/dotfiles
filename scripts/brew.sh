#!/usr/bin/env bash
# ==============================================================================
# Homebrew 與核心工具安裝腳本
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$SCRIPT_DIR/.." && pwd)}"
source "$SCRIPT_DIR/lib.sh"

info "檢查並安裝 Homebrew 及核心工具..."

if ! command -v brew &>/dev/null; then
  warning "未偵測到 Homebrew，正在安裝 Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  success "Homebrew 已就緒。"
fi

BREWFILE="$DOTFILES_DIR/Brewfile"
if [ -f "$BREWFILE" ]; then
  info "正在透過 Brewfile 安裝工具 (starship, zoxide, fzf, eza, lazygit, 字體等)..."
  brew bundle --file="$BREWFILE"
  success "所有 Homebrew 套件與 Nerd Font 字體安裝完成！"
else
  warning "找不到 Brewfile: $BREWFILE"
fi
