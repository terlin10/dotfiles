# 🚀 Shawn's Modern Dotfiles & AI Agent Skills

一套為現代軟體工程師量身打造的**模組化開發環境與 AI 助理技能庫**。具備極致啟動速度、美觀毛玻璃介面、IDE 級別自動建議，並整合 Antigravity AI Agent 專業技能。

支援**「一鍵全套安裝」**與**「各別模組按需獨立安裝」**，免 Clone 即可透過遠端一行指令快速套用。

---

## 🌟 核心特色

### 1. 終端機與開發流
* **GPU 加速終端機 ([Ghostty](https://ghostty.org/))**：
  * 毛玻璃透明背景（不透明度 0.85，Blur 啟用）
  * 無邊界透明標題列
  * 滑鼠選取文字即時自動複製（如同 iTerm2）
  * 適合長時間閱讀的 [**JetBrains Mono Nerd Font**](https://www.nerdfonts.com/)（字號 14）
  * 記憶工作狀態（重開自動復原分頁與目錄路徑）與最佳化視窗內距（Padding）
* **現代提示符 ([Starship](https://starship.rs/))**：
  * 官方 **Tokyo-Night** 膠囊彩帶主題
  * 清楚顯示當前目錄、Git 分支狀態與執行時間
* **Zsh 輸入體驗強化**：
  * [**`zsh-autosuggestions`**](https://github.com/zsh-users/zsh-autosuggestions)：像 IDE 一樣根據歷史指令浮現淡灰色建議，按 `→` 一鍵補齊。
  * [**`zsh-syntax-highlighting`**](https://github.com/zsh-users/zsh-syntax-highlighting)：打字即時語法高亮（正確變綠色、打錯變紅色）。
  * [**`zoxide`**](https://github.com/ajeetdsouza/zoxide)：智慧目錄跳轉，打 `z <關鍵字>` 盲跳。
  * [**`fzf`**](https://github.com/junegunn/fzf)：終端模糊搜尋器，支援 `zi` 互動跳轉、按 `Ctrl + R` 模糊搜尋歷史指令。
  * [**`eza`**](https://github.com/eza-community/eza)：新一代 `ls`，彩色權限標記與檔案專屬圖示。
* **Git 開發流**：
  * **`git lg`**：彩色分支樹狀線圖（附加 `--all` 可看全部分支）。
  * [**`lazygit`**](https://github.com/jesseduffield/lazygit)：全鍵盤操作的終端 Git 視覺化介面。
  * [**`glow`**](https://github.com/charmbracelet/glow)：終端 Markdown 精美排版渲染與分頁閱讀器。

### 2. Antigravity AI Agent 技能與外掛庫
* **`code-review`**（來源：[mattpocock/skills](https://github.com/mattpocock/skills)）：雙軸代碼審查（規範軸 + 規格軸獨立並行，杜絕單重視角盲區）。
* **`research`**（來源：[mattpocock/skills](https://github.com/mattpocock/skills)）：第一手原始文檔與官方 API 深入調研，輸出結構化研究筆記。
* **`retro`**（來源：[mattpocock/skills](https://github.com/mattpocock/skills)）：開發會話回顧與環境優化建議（診斷導航、自動化防護網、規格邊界）。
* **`writing-for-agents`**（來源：[mattpocock/skills](https://github.com/mattpocock/skills)）：Agent 專用文檔與技能編寫指南（漸進式揭露、精準觸發詞規劃）。
* **`skill-creator`**（來源：[anthropics/skills](https://github.com/anthropics/skills)）：技能建立、評估反覆運算與觸發精準度最佳化工具。
* **`i-have-adhd`**（來源：[ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)）：行動優先、零廢話、多步驟編號條列的極致輸出風格規範。

---

## ⚡ 遠端一行指令快速安裝（免 Clone）

### 🔥 一鍵全套安裝（推薦全新電腦）
```bash
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash
```

---

### 📦 各別模組獨立安裝指令（隨選隨用）

#### 終端機與系統工具
```bash
# 只安裝 Ghostty 毛玻璃與按鍵設定
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- ghostty

# 只配置 Zsh 增強外掛（預設非破壞式保留原有 .zshrc）
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- zsh

# 只套用 Starship Tokyo-Night 彩帶主題
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- starship

# 只配置 Git 彩色樹狀圖別名 (git lg)
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- git

# 只透過 Brewfile 安裝核心套件與 Nerd Font 字體
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- brew
```

#### AI Agent 技能與外掛
```bash
# 安裝全部 AI Agent 技能與外掛
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- skills all

# 只安裝代碼審查技能 (code-review)
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- skills code-review

# 只安裝 ADHD 友善外掛 (i-have-adhd)
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- skills i-have-adhd

# 同時指定多個項目 (例如: code-review 與 research)
curl -fsSL https://raw.githubusercontent.com/terlin10/dotfiles/main/install.sh | bash -s -- skills code-review research
```

---

## 💻 本地執行方式（已 Clone 儲存庫）

```bash
git clone https://github.com/terlin10/dotfiles.git ~/dotfiles
cd ~/dotfiles

./install.sh            # 互動式主選單（可自由選擇全裝或各模組）
./install.sh ghostty    # 單獨安裝 Ghostty
./install.sh zsh        # 單獨安裝 Zsh
./install.sh skills     # 進入 Skills 挑選選單（或接特定 skill 名稱）
./install.sh all        # 一鍵全套安裝
```

---

## 📁 專案架構

```text
dotfiles/
├── install.sh                  # 主進入點（支援參數分流、一鍵全裝與互動選單）
├── setup.sh                    # 相容性封裝（自動導向 install.sh）
├── Brewfile                    # Homebrew 套件與字體清單
├── scripts/                    # 各模組獨立安裝腳本
│   ├── lib.sh                  # 共用色彩與輔助函式
│   ├── ghostty.sh              # Ghostty 設定安裝
│   ├── zsh.sh                  # Zsh 設定安裝
│   ├── starship.sh             # Starship 設定安裝
│   ├── git.sh                  # Git 設定安裝
│   ├── brew.sh                 # Homebrew 套件安裝
│   └── skills.sh               # AI Agent Skills/Plugins 多選安裝
├── config/
│   ├── ghostty/config          # Ghostty 外觀與視窗狀態設定
│   ├── starship.toml           # Tokyo-Night 提示符主題
│   └── gemini/skills/          # 集中管理的 AI Agent 技能庫
│       ├── code-review/
│       ├── research/
│       ├── retro/
│       ├── skill-creator/
│       └── writing-for-agents/
└── zsh/
    ├── .zshrc                  # 全新電腦獨立完整版
    └── .zshrc_custom           # 現有電腦非破壞式外掛版
```

---

## 🙏 致謝與上游來源（Credits & References）

感謝以下卓越的開源專案與作者貢獻：

### 終端與系統工具
* **[Ghostty](https://ghostty.org/)**：由 Mitchell Hashimoto 開發的下一代高效能 GPU 加速終端機。
* **[Starship](https://starship.rs/)**：極速、可無限自訂的跨 Shell 提示符工具。
* **[Nerd Fonts](https://www.nerdfonts.com/)**：為開發者修補完整圖示的高品質字體專案（JetBrains Mono Nerd Font）。
* **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** & **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**：極致提升終端打字體驗的 Zsh 外掛。
* **[zoxide](https://github.com/ajeetdsouza/zoxide)**、**[fzf](https://github.com/junegunn/fzf)**、**[eza](https://github.com/eza-community/eza)**、**[lazygit](https://github.com/jesseduffield/lazygit)**、**[glow](https://github.com/charmbracelet/glow)**。

### AI Agent 技能與外掛來源
* **[mattpocock/skills](https://github.com/mattpocock/skills)**：由 Matt Pocock 維護的工程師 Agent 技能庫（收錄 `code-review`、`research`、`retro`、`writing-for-agents`）。
* **[anthropics/skills](https://github.com/anthropics/skills)**：Anthropic 官方維護的技能範例庫（收錄 `skill-creator`）。
* **[ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)**：由 ayghri 維護的 ADHD 友善極致輸出風格規範。
