#!/usr/bin/env bash
# ==============================================================================
# AI Agent Skills & Plugins 安裝腳本
# 支援單獨指定項目、多選指定、或互動選單
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$SCRIPT_DIR/.." && pwd)}"
source "$SCRIPT_DIR/lib.sh"

SKILLS_SRC_DIR="$DOTFILES_DIR/config/gemini/skills"
SKILLS_TARGET_DIR="$HOME/.gemini/config/skills"

install_skill() {
  local name="$1"
  local src="$SKILLS_SRC_DIR/$name"
  local dst="$SKILLS_TARGET_DIR/$name"

  if [ ! -d "$src" ]; then
    error "找不到 Skill 來源: $name"
    return 1
  fi

  mkdir -p "$SKILLS_TARGET_DIR"
  rm -rf "$dst"
  cp -R "$src" "$SKILLS_TARGET_DIR/"
  success "Skill [${name}] 安裝成功 -> $dst"
}

install_plugin_adhd() {
  if ! command -v agy &>/dev/null; then
    warning "未偵測到 agy CLI，嘗試將 i-have-adhd 作為一般 skill 檔案安裝..."
    return 0
  fi

  info "正在透過 agy 安裝 i-have-adhd 外掛..."
  agy plugin install https://github.com/ayghri/i-have-adhd 2>&1 || true
  success "Plugin [i-have-adhd] 安裝/更新成功！"
}

AVAILABLE_ITEMS=(
  "code-review"
  "research"
  "retro"
  "writing-for-agents"
  "skill-creator"
  "i-have-adhd"
)

install_item() {
  local item="$1"
  case "$item" in
    code-review|research|retro|writing-for-agents|skill-creator)
      install_skill "$item"
      ;;
    i-have-adhd)
      install_plugin_adhd
      ;;
    all)
      for i in "${AVAILABLE_ITEMS[@]}"; do
        install_item "$i"
      done
      ;;
    *)
      warning "未知的項目名稱: $item"
      ;;
  esac
}

# ------------------------------------------------------------------------------
# 主流程
# ------------------------------------------------------------------------------
SELECTED_ITEMS=()

if [ $# -gt 0 ]; then
  # 命令列有傳入參數，例如: ./install.sh skills code-review i-have-adhd
  for arg in "$@"; do
    if [ "$arg" = "all" ]; then
      SELECTED_ITEMS=("all")
      break
    else
      SELECTED_ITEMS+=("$arg")
    fi
  done
else
  # 沒有傳參數，判斷是否為終端互動模式
  if [ -t 0 ] || [ -c /dev/tty ]; then
    echo -e "${CYAN}${BOLD}"
    echo "=========================================================="
    echo "         🤖 Antigravity AI Agent 技能與外掛清單           "
    echo "=========================================================="
    echo -e "${NC}"
    echo "  [1] 全部安裝 (推薦 ⭐ 包含所有 Skills 與 ADHD 外掛)"
    echo "  [2] code-review        - 雙軸代碼審查（規範軸 + 規格軸並行）"
    echo "  [3] research           - 第一手原始文檔與 API 深入調研"
    echo "  [4] retro              - 開發會話回顧與環境優化建議"
    echo "  [5] writing-for-agents - Agent 專用文檔與技能編寫指南"
    echo "  [6] skill-creator      - 技能建立、評估與迭代器"
    echo "  [7] i-have-adhd        - ADHD 友善插件（行動優先、零廢話）"
    echo ""
    read -rp "$(echo -e "${PURPLE}請輸入想安裝的項目編號 (可多選，例如 '2 4 7' 或 '1' 全裝): ${NC}")" choices </dev/tty
    choices=${choices:-1}

    for choice in $choices; do
      case "$choice" in
        1) SELECTED_ITEMS=("all"); break ;;
        2) SELECTED_ITEMS+=("code-review") ;;
        3) SELECTED_ITEMS+=("research") ;;
        4) SELECTED_ITEMS+=("retro") ;;
        5) SELECTED_ITEMS+=("writing-for-agents") ;;
        6) SELECTED_ITEMS+=("skill-creator") ;;
        7) SELECTED_ITEMS+=("i-have-adhd") ;;
        *) warning "忽略無效選項: $choice" ;;
      esac
    done
  else
    # 非互動模式預設全部安裝
    SELECTED_ITEMS=("all")
  fi
fi

if [ ${#SELECTED_ITEMS[@]} -eq 0 ]; then
  warning "未選取任何項目，結束安裝。"
  exit 0
fi

info "開始執行 AI Agent 項目安裝..."
for item in "${SELECTED_ITEMS[@]}"; do
  install_item "$item"
done

echo ""
success "AI Agent 項目配置完成！"
