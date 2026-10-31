#!/usr/bin/env bash
# ==============================================================================
# Shawn's Modern Dotfiles Setup Wizard
# 適用於全新 Mac 或現有電腦的非破壞式自動化安裝工具
# ==============================================================================

set -e

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_banner() {
  clear 2>/dev/null || true
  echo -e "${CYAN}${BOLD}"
  echo "=========================================================="
  echo "         🚀 Shawn's Dotfiles 現代終端安裝小幫手          "
  echo "=========================================================="
  echo -e "${NC}"
  echo -e "本腳本將協助您配置：Ghostty、Starship (Tokyo-Night)、"
  echo -e "Zsh 補全/高亮/跳轉神器、JetBrains Mono Nerd Font 與 Git 捷徑。\n"
}

info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

success() {
  echo -e "${GREEN}✅ $1${NC}"
}

warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

ask_yes_no() {
  local prompt="$1"
  local default="$2"
  local answer
  if [ "$default" = "y" ]; then
    read -rp "$(echo -e "${PURPLE}[?] ${prompt} [Y/n]: ${NC}")" answer
    answer=${answer:-y}
  else
    read -rp "$(echo -e "${PURPLE}[?] ${prompt} [y/N]: ${NC}")" answer
    answer=${answer:-n}
  fi
  [[ "$answer" =~ ^[Yy]$ ]]
}

# ------------------------------------------------------------------------------
# 1. 主選單選擇
# ------------------------------------------------------------------------------
print_banner

echo -e "${BOLD}請選擇安裝模式：${NC}"
echo "  [1] 一鍵全部安裝 (推薦 ⭐ 適合全新 Mac 或希望直接享受完整環境)"
echo "  [2] 自訂挑選安裝項目 (適合現有電腦，可自由決定要裝哪些工具)"
echo ""
read -rp "$(echo -e "${PURPLE}請輸入選項 [1/2] (預設 1): ${NC}")" mode
mode=${mode:-1}

INSTALL_BREW=true
INSTALL_GHOSTTY=true
INSTALL_STARSHIP=true
INSTALL_ZSH=true
INSTALL_GIT=true

if [ "$mode" = "2" ]; then
  echo ""
  info "進入自訂挑選模式："
  ask_yes_no "是否安裝 Homebrew 核心工具與 JetBrains Mono Nerd Font？" "y" || INSTALL_BREW=false
  ask_yes_no "是否套用 Ghostty 設定 (毛玻璃0.85、快捷複製、字體14)？" "y" || INSTALL_GHOSTTY=false
  ask_yes_no "是否套用 Starship Tokyo-Night 彩帶提示符主題？" "y" || INSTALL_STARSHIP=false
  ask_yes_no "是否配置 Zsh 增強外掛 (自動補全、語法高亮、zoxide、fzf 等)？" "y" || INSTALL_ZSH=false
  ask_yes_no "是否設定 Git lg 彩色樹狀分支圖別名？" "y" || INSTALL_GIT=false
fi

echo ""
info "開始執行安裝設定..."
echo "----------------------------------------------------------"

# ------------------------------------------------------------------------------
# 2. 安裝 Homebrew 與套件
# ------------------------------------------------------------------------------
if [ "$INSTALL_BREW" = true ]; then
  echo ""
  info "步驟 1: 檢查並安裝 Homebrew 及核心工具..."
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

  info "正在透過 Brewfile 安裝工具 (starship, zoxide, fzf, eza, lazygit, 字體等)..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  success "所有 Homebrew 套件與 Nerd Font 字體安裝完成！"
fi

# ------------------------------------------------------------------------------
# 3. 配置 Ghostty
# ------------------------------------------------------------------------------
if [ "$INSTALL_GHOSTTY" = true ]; then
  echo ""
  info "步驟 2: 配置 Ghostty 終端機外觀..."
  
  # 支援標準路徑與 macOS Application Support 路徑
  mkdir -p "$HOME/.config/ghostty"
  mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

  cp "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
  cp "$DOTFILES_DIR/config/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

  success "Ghostty 設定已成功套用 (毛玻璃 0.85、字體 14、選取即複製、透明標題列)！"
fi

# ------------------------------------------------------------------------------
# 4. 配置 Starship 主題
# ------------------------------------------------------------------------------
if [ "$INSTALL_STARSHIP" = true ]; then
  echo ""
  info "步驟 3: 配置 Starship 提示符主題 (Tokyo-Night)..."
  mkdir -p "$HOME/.config"
  cp "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
  success "Starship 主題設定檔已就緒 (~/.config/starship.toml)！"
fi

# ------------------------------------------------------------------------------
# 5. 配置 Zsh (智慧判斷與非破壞式支援)
# ------------------------------------------------------------------------------
if [ "$INSTALL_ZSH" = true ]; then
  echo ""
  info "步驟 4: 配置 Zsh 環境..."
  
  ZSHRC="$HOME/.zshrc"
  CUSTOM_ZSHRC="$HOME/.zshrc_custom"

  if [ -f "$ZSHRC" ]; then
    echo ""
    warning "偵測到您的家目錄下已存在 ~/.zshrc！"
    echo -e "${BOLD}請選擇如何處理 ~/.zshrc：${NC}"
    echo "  [1] 非破壞式外掛引入 (推薦 ⭐ 完整保留原有設定，只在最末尾 source 模組)"
    echo "  [2] 備份舊檔案並完全覆蓋 (舊檔將自動儲存為 ~/.zshrc.bak)"
    echo "  [3] 跳過 Zsh 設定"
    echo ""
    read -rp "$(echo -e "${PURPLE}請選擇處理方式 [1/2/3] (預設 1): ${NC}")" zsh_choice
    zsh_choice=${zsh_choice:-1}

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
fi

# ------------------------------------------------------------------------------
# 6. 配置 Git lg 別名
# ------------------------------------------------------------------------------
if [ "$INSTALL_GIT" = true ]; then
  echo ""
  info "步驟 5: 配置 Git 彩色樹狀分支圖別名 (git lg)..."
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  success "Git 全域別名 'git lg' 設定成功 (支援附加 --all)！"
fi

# ------------------------------------------------------------------------------
# 完成總結
# ------------------------------------------------------------------------------
echo ""
echo "=========================================================="
echo -e "${GREEN}${BOLD}🎉 恭喜！現代化開發環境已全部部署完畢！${NC}"
echo "=========================================================="
echo -e "建議您執行以下指令立即體驗，或重新開啟終端機分頁："
echo -e "  ${CYAN}source ~/.zshrc${NC}\n"
echo -e "祝您開發愉快！ 🚀"
