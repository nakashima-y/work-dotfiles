# Work Dotfiles

業務用の開発環境設定をGNU Stowで管理するリポジトリです。快適なzsh環境とGit分析ツールを提供します。

## 🔗 仕組み（GNU Stow + シンボリックリンク）

GNU Stowを使用して、設定ファイルをシンボリックリンクで管理しています。

### 具体例
```bash
# 実際のファイルの場所
~/work-dotfiles/zsh/.zshrc

# ホームディレクトリのシンボリックリンク
~/.zshrc -> work-dotfiles/zsh/.zshrc
```

### メリット
**集中管理**: すべての設定ファイルが `~/work-dotfiles/` に集約され、Git でバージョン管理・複数マシン間での同期が可能になります。

## 📁 構成

```
~/work-dotfiles/
├── zsh/
│   ├── .zshrc                      # zshメイン設定（Homebrew環境自動判定）
│   ├── .zshenv                     # 環境変数
│   ├── .zprofile                   # ログインシェル設定
│   ├── .zlogin                     # ログイン後設定
│   ├── .zlogout                    # ログアウト設定
│   └── .zpreztorc                  # Prezto設定
├── zprezto/
│   └── .zprezto/                   # Preztoフレームワーク（カスタムモジュール含む）
├── homebrew/
│   └── .Brewfile                   # 最小構成（zsh-completions + フォント）
└── claude/
    └── .claude/
        └── commands/               # Claude Codeカスタムコマンド
            ├── analyze-branch-diff.md
            ├── analyze-commit.md
            ├── analyze-current-changes.md
            └── review-code.md
```

## 🚀 セットアップ

### 前提条件
- macOS
- [Homebrew](https://brew.sh/)
- Git

### インストール手順

1. **GNU Stowをインストール:**
   ```bash
   brew install stow
   ```

2. **このリポジトリをクローン:**
   ```bash
   git clone https://github.com/nakashima-y/work-dotfiles.git ~/work-dotfiles
   cd ~/work-dotfiles
   ```

3. **設定ファイルを適用（シンボリックリンク作成）:**
   ```bash
   # すべての設定を適用
   stow zsh zprezto homebrew claude
   
   # 結果例:
   # ~/.zshrc -> ~/work-dotfiles/zsh/.zshrc (シンボリンク作成)
   # ~/.zprezto -> ~/work-dotfiles/zprezto/.zprezto (シンボリンク作成)
   ```

4. **追加パッケージをインストール:**
   ```bash
   brew bundle install
   ```

5. **設定確認:**
   ```bash
   # シンボリンクが正しく作成されているか確認
   ls -la ~/ | grep "\->"
   
   # zsh設定を読み込み
   source ~/.zshrc
   # または新しいターミナルセッションを開く
   ```

## 🔧 設定詳細

### シェル環境（zsh + Prezto）
- **フレームワーク**: [Prezto](https://github.com/sorin-ionescu/prezto) + カスタムモジュール
- **有効なモジュール**: 
  - autosuggestions（コマンド自動補完）
  - completion（補完機能拡張）
  - fasd（ディレクトリ・ファイル高速アクセス）
  - history-substring-search（履歴検索）
- **利用可能テーマ**: PowerLevel10k、PowerLevel9k、Agnoster、Powerline

### Homebrew環境自動判定
Intel MacとApple Silicon Macの両方に対応：
```bash
# Apple Silicon
export PATH="/opt/homebrew/bin:$PATH"

# Intel / Rosetta環境
eval "$(/usr/local/bin/brew shellenv)"
```

### 追加ツール（Homebrew）
- **zsh-completions**: 追加のzsh補完スクリプト
- **font-fira-code**: プログラミング用フォント

### Claude Codeコマンド
Git分析・コードレビュー用カスタムコマンド:
- `analyze-branch-diff`: ブランチ比較・差分分析
- `analyze-commit`: 詳細なコミット分析・レビュー
- `analyze-current-changes`: 現在の変更内容をレビュー
- `review-code`: 包括的コードレビュー支援

## 🔄 設定の変更管理

### 設定ファイルの編集
設定を変更する際は、ホームディレクトリのファイル（シンボリンク）を直接編集してください：
```bash
# これらはすべて同じファイルを編集している
vim ~/.zshrc                      # シンボリンク経由で編集
vim ~/work-dotfiles/zsh/.zshrc   # 実ファイルを直接編集

# どちらで編集しても、変更は ~/work-dotfiles/ 内の実ファイルに反映される
```

### 設定の同期
```bash
cd ~/work-dotfiles
git add .
git commit -m "Update configuration"
git push
```

## 🛠️ トラブルシューティング

### Stowで競合が発生する場合
既存のファイルがある場合は `--adopt` オプションを使用：
```bash
stow zsh --adopt
```

### Preztoモジュールが正常に動作しない場合
```bash
# Prezto設定を再読み込み
source ~/.zshrc

# または新しいターミナルセッションを開く
```

## 🎯 対応環境
- **Apple Silicon Mac**（/opt/homebrew）
- **Intel Mac / Rosetta環境**（/usr/local）
- **macOS標準zsh** + **Homebrew追加パッケージ**

## 📚 参考資料
- [GNU Stow公式](https://www.gnu.org/software/stow/)
- [Prezto](https://github.com/sorin-ionescu/prezto)
- [dotfiles管理のベストプラクティス](https://dotfiles.github.io/)