#!/usr/bin/env bash
# ==============================================================================
# 共用函式庫與色彩定義
# ==============================================================================

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

success() {
  echo -e "${GREEN}✅ $1${NC}"
}

warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
  echo -e "${RED}❌ $1${NC}"
}

ask_yes_no() {
  local prompt="$1"
  local default="$2"
  local answer
  if [ "$default" = "y" ]; then
    read -rp "$(echo -e "${PURPLE}[?] ${prompt} [Y/n]: ${NC}")" answer </dev/tty
    answer=${answer:-y}
  else
    read -rp "$(echo -e "${PURPLE}[?] ${prompt} [y/N]: ${NC}")" answer </dev/tty
    answer=${answer:-n}
  fi
  [[ "$answer" =~ ^[Yy]$ ]]
}
