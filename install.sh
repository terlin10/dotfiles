#!/usr/bin/env bash
# ==============================================================================
# Modern Dotfiles 安裝精靈
# 支援模組化單獨安裝、一鍵全裝、與遠端 curl | bash 執行
# ==============================================================================
set -e

# ------------------------------------------------------------------------------
# 1. 環境判斷與遠端相容處理
# ------------------------------------------------------------------------------
SCRIPT_SOURCE="${BASH_SOURCE[0]}"
LOCAL_DIR=""
if [ -n "$SCRIPT_SOURCE" ] && [ -f "$SCRIPT_SOURCE" ]; then
  LOCAL_DIR="$(cd "$(dirname "$SCRIPT_SOURCE")" 2>/dev/null && pwd)"
fi

if [ -n "$LOCAL_DIR" ] && [ -d "$LOCAL_DIR/scripts" ] && [ -d "$LOCAL_DIR/config" ]; then
  DOTFILES_DIR="$LOCAL_DIR"
else
  # 透過 curl | bash 遠端呼叫
  DOTFILES_TEMP_DIR=$(mktemp -d /tmp/dotfiles-XXXXXX)
  trap 'rm -rf "$DOTFILES_TEMP_DIR"' EXIT
  echo "⬇️ 正在下載最新 dotfiles 設定檔..."
  git clone --depth=1 https://github.com/terlin10/dotfiles.git "$DOTFILES_TEMP_DIR" >/dev/null 2>&1
  DOTFILES_DIR="$DOTFILES_TEMP_DIR"
fi

export DOTFILES_DIR
source "$DOTFILES_DIR/scripts/lib.sh"

# ------------------------------------------------------------------------------
# 2. 顯示主選單橫幅
# ------------------------------------------------------------------------------
show_banner() {
  clear 2>/dev/null || true
  echo -e "${CYAN}${BOLD}"
  echo "=========================================================="
  echo "                🚀 Modern Dotfiles 精靈                   "
  echo "=========================================================="
  echo -e "${NC}"
  echo -e "模組化終端環境配置工具\n"
}

# ------------------------------------------------------------------------------
# 3. 模組分流執行
# ------------------------------------------------------------------------------
run_all() {
  info "開始執行全套安裝..."
  "$DOTFILES_DIR/scripts/brew.sh"
  "$DOTFILES_DIR/scripts/ghostty.sh"
  "$DOTFILES_DIR/scripts/starship.sh"
  "$DOTFILES_DIR/scripts/zsh.sh"
  "$DOTFILES_DIR/scripts/git.sh"
  echo ""
  echo "=========================================================="
  echo -e "${GREEN}${BOLD}🎉 恭喜！現代化開發環境全部配置完畢！${NC}"
  echo "=========================================================="
  echo -e "建議執行以下指令立即生效，或重新開啟終端機分頁："
  echo -e "  ${CYAN}source ~/.zshrc${NC}\n"
}

# 檢查指令參數
TARGET="${1:-}"

case "$TARGET" in
  ghostty)
    "$DOTFILES_DIR/scripts/ghostty.sh"
    ;;
  zsh)
    "$DOTFILES_DIR/scripts/zsh.sh"
    ;;
  starship)
    "$DOTFILES_DIR/scripts/starship.sh"
    ;;
  git)
    "$DOTFILES_DIR/scripts/git.sh"
    ;;
  brew)
    "$DOTFILES_DIR/scripts/brew.sh"
    ;;
  all)
    run_all
    ;;
  help|--help|-h)
    echo "使用方式："
    echo "  ./install.sh [模組名稱] [參數...]"
    echo ""
    echo "支援的模組："
    echo "  all                  一鍵安裝全部 (Brew + Ghostty + Starship + Zsh + Git)"
    echo "  ghostty              只安裝 Ghostty 設定"
    echo "  zsh                  只安裝 Zsh 外掛與設定"
    echo "  starship             只安裝 Starship 提示符主題"
    echo "  git                  只配置 Git lg 彩色別名"
    echo "  brew                 只透過 Brewfile 安裝工具與字體"
    echo ""
    echo "範例："
    echo "  ./install.sh ghostty"
    echo "  ./install.sh all"
    echo "  curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- ghostty"
    ;;
  "")
    # 無參數時，進入互動選單
    show_banner
    echo -e "${BOLD}請選擇安裝項目：${NC}"
    echo "  [1] 一鍵全部安裝 (推薦 ⭐ 適合全新 Mac)"
    echo "  [2] Ghostty 終端機 (毛玻璃 0.85、字體 14、快速複製、分頁狀態)"
    echo "  [3] Zsh 增強外掛 (自動補全、語法高亮、非破壞式支援)"
    echo "  [4] Starship 提示符 (Tokyo-Night 彩帶主題)"
    echo "  [5] Git 彩色樹狀別名 (git lg)"
    echo "  [6] Homebrew 核心工具與 Nerd Font 字體"
    echo "  [q] 離開"
    echo ""
    read -rp "$(echo -e "${PURPLE}請輸入選項 [1-6/q] (預設 1): ${NC}")" menu_choice </dev/tty
    menu_choice=${menu_choice:-1}

    case "$menu_choice" in
      1) run_all ;;
      2) "$DOTFILES_DIR/scripts/ghostty.sh" ;;
      3) "$DOTFILES_DIR/scripts/zsh.sh" ;;
      4) "$DOTFILES_DIR/scripts/starship.sh" ;;
      5) "$DOTFILES_DIR/scripts/git.sh" ;;
      6) "$DOTFILES_DIR/scripts/brew.sh" ;;
      q|Q) info "已取消安裝。" ;;
      *) warning "無效選項，結束執行。" ;;
    esac
    ;;
  *)
    error "未知的模組名稱: $TARGET"
    echo "執行 './install.sh help' 查看可用模組。"
    exit 1
    ;;
esac
