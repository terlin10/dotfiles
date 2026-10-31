# 🚀 Shawn's Modern Dotfiles

一套為前端工程師量身打造的現代化終端開發環境。具備**極致啟動速度、美觀毛玻璃介面、IDE 級別自動建議、語法防呆高亮與智慧跳轉**。

---

## 🌟 核心特色

* **GPU 加速終端機 (Ghostty)**：
  * 毛玻璃透明背景（不透明度 0.85，Blur 啟用）
  * 無邊界透明標題列
  * 滑鼠選取文字即時自動複製（如同 iTerm2）
  * 適合前端長時間閱讀的 **JetBrains Mono Nerd Font**（字號 14）
* **現代提示符 (Starship)**：
  * 官方 **Tokyo-Night** 膠囊彩帶主題
  * 清楚顯示當前目錄、Git 分支狀態與時間
* **Zsh 輸入體驗強化**：
  * **`zsh-autosuggestions`**：像 IDE 一樣根據歷史指令浮現淡灰色建議，按 `→` 一鍵補齊。
  * **`zsh-syntax-highlighting`**：打字即時語法高亮（正確變綠色、打錯變紅色）。
  * **`zoxide`**：智慧目錄跳轉，打 `z <關鍵字>` 盲跳。
  * **`fzf`**：終端模糊搜尋器，支援 `zi` 互動跳轉、按 `Ctrl + R` 模糊搜尋歷史指令。
  * **`eza`**：新一代 `ls`，彩色權限標記與檔案專屬圖示。
* **Git 開發流與閱讀體驗**：
  * **`git lg`**：彩色分支樹狀線圖（附加 `--all` 可看全部分支）。
  * **`lazygit`**：全鍵盤操作的終端 Git 視覺化介面。
  * **`glow`**：終端 Markdown 精美排版渲染與分頁閱讀器。

---

## 💻 在新電腦快速安裝

### 步驟 1：Clone 此儲存庫
```bash
git clone <你的 GitHub dotfiles 網址> ~/dotfiles
cd ~/dotfiles
```

### 步驟 2：執行安裝精靈
```bash
bash setup.sh
```

### 步驟 3：依需求選擇
* **全新電腦**：選擇 `[1] 一鍵全部安裝`。
* **已有環境的電腦**：選擇 `[2] 自訂挑選安裝項目`，並在 `.zshrc` 選項中選擇 `[1] 非破壞式外掛引入`，**既有設定與環境變數 100% 完整保留**。

---

## 📁 檔案結構

```text
dotfiles/
├── Brewfile              # Homebrew 套件與字體定義檔
├── config/
│   ├── ghostty/config    # Ghostty 外觀與設定
│   └── starship.toml     # Tokyo-Night 提示符主題
├── zsh/
│   ├── .zshrc            # 全新電腦獨立完整版
│   └── .zshrc_custom     # 現有電腦非破壞式外掛版
├── setup.sh              # 智慧安裝精靈
└── README.md             # 本文件
```
