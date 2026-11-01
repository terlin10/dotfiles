#!/usr/bin/env bash
# ==============================================================================
# Zsh 增強配置安裝腳本
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$SCRIPT_DIR/.." && pwd)}"
source "$SCRIPT_DIR/lib.sh"

info "開始配置 Zsh 終端體驗..."

ZSHRC="$HOME/.zshrc"
CUSTOM_ZSHRC="$HOME/.zshrc_custom"

if [ -f "$ZSHRC" ]; then
  # 判斷是否有 tty 可進行互動
  if [ -t 0 ] || [ -c /dev/tty ]; then
    echo ""
    warning "偵測到您的家目錄下已存在 ~/.zshrc！"
    echo -e "${BOLD}請選擇如何處理 ~/.zshrc：${NC}"
    echo "  [1] 非破壞式外掛引入 (推薦 ⭐ 完整保留原有設定，只在最末尾 source 模組)"
    echo "  [2] 備份舊檔案並完全覆蓋 (舊檔將自動儲存為 ~/.zshrc.bak)"
    echo "  [3] 跳過 Zsh 設定"
    echo ""
    read -rp "$(echo -e "${PURPLE}請選擇處理方式 [1/2/3] (預設 1): ${NC}")" zsh_choice </dev/tty
    zsh_choice=${zsh_choice:-1}
  else
    # 非互動模式預設安全模式 (非破壞式)
    zsh_choice=1
  fi

  case "$zsh_choice" in
    1)
      cp "$DOTFILES_DIR/zsh/.zshrc_custom" "$CUSTOM_ZSHRC"
      if ! grep -q "source.*\.zshrc_custom" "$ZSHRC"; then
        echo -e "\n# Shawn's Modern Dotfiles Enhancement\n[[ -f ~/.zshrc_custom ]] && source ~/.zshrc_custom" >> "$ZSHRC"
      fi
      success "已採用非破壞式整合！舊設定完全保留，並已載入 ~/.zshrc_custom。"
      ;;
    2)
      BACKUP_FILE="$ZSHRC.bak.$(date +%Y%m%d%H%M%S)"
      cp "$ZSHRC" "$BACKUP_FILE"
      warning "原有設定已備份至: $BACKUP_FILE"
      cp "$DOTFILES_DIR/zsh/.zshrc" "$ZSHRC"
      success "已全新覆蓋 ~/.zshrc！"
      ;;
    3)
      info "已跳過 Zsh 設定。"
      ;;
  esac
else
  # 全新電腦，無任何 .zshrc
  cp "$DOTFILES_DIR/zsh/.zshrc" "$ZSHRC"
  success "已為全新環境建立標準的 ~/.zshrc！"
fi
