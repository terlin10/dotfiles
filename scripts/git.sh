#!/usr/bin/env bash
# ==============================================================================
# Git 設定與別名安裝腳本
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

info "配置 Git 彩色樹狀分支圖別名 (git lg)..."

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

success "Git 全域別名 'git lg' 設定成功 (支援附加 --all)！"
