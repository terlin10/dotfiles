#!/usr/bin/env bash
# ==============================================================================
# Starship 提示符主題設定安裝腳本
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$SCRIPT_DIR/.." && pwd)}"
source "$SCRIPT_DIR/lib.sh"

info "開始配置 Starship 提示符主題 (Tokyo-Night)..."

CONFIG_SRC="$DOTFILES_DIR/config/starship.toml"
if [ ! -f "$CONFIG_SRC" ]; then
  error "找不到 Starship 設定檔: $CONFIG_SRC"
  exit 1
fi

mkdir -p "$HOME/.config"
cp "$CONFIG_SRC" "$HOME/.config/starship.toml"

success "Starship 主題設定檔已就緒 (~/.config/starship.toml)！"
