#!/usr/bin/env bash
# ==============================================================================
# Ghostty 終端機設定安裝腳本
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$SCRIPT_DIR/.." && pwd)}"
source "$SCRIPT_DIR/lib.sh"

info "開始配置 Ghostty 終端機外觀..."

CONFIG_SRC="$DOTFILES_DIR/config/ghostty/config"
if [ ! -f "$CONFIG_SRC" ]; then
  error "找不到 Ghostty 設定檔: $CONFIG_SRC"
  exit 1
fi

# 支援標準路徑與 macOS Application Support 路徑
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

cp "$CONFIG_SRC" "$HOME/.config/ghostty/config"
cp "$CONFIG_SRC" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

success "Ghostty 設定已成功套用！"
echo "  • 毛玻璃透明背景 (不透明度 0.85, Blur 啟用)"
echo "  • JetBrains Mono Nerd Font (字號 14)"
echo "  • 滑鼠選取即自動複製 & 修剪空白"
echo "  • 記憶視窗與分頁狀態 (window-save-state = always)"
echo "  • 最佳化視窗內距 (window-padding-x = 4)"
