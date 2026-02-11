# dotfiles

macOS の開発環境設定を管理するリポジトリ

## 目次

- [セットアップ](#セットアップ)
- [Homebrew](#homebrew)
- [zsh](#zsh)
- [powerline-shell](#powerline-shell)
- [エディタ](#エディタ)
- [Ruby](#ruby)
- [AI エージェント設定](#ai-エージェント共通設定)
- [その他](#その他)

## セットアップ

### クイックスタート

```bash
# 1. リポジトリをクローン
git clone https://${GIT_USER_PRIVATE}:${GIT_TOKEN_PRIVATE}@github.com/${GIT_USER_PRIVATE}/dotfiles ~/dotfiles

# 2. Homebrew をインストール（未インストール時）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. パッケージをインストール
cd ~/dotfiles/homebrew
brew bundle

# 4. zsh を設定
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
source ~/.zshrc
```

詳細なセットアップは以下のセクションを参照すること。

## Homebrew

パッケージマネージャーとしての Homebrew をセットアップする。

### インストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### パッケージをまとめてインストール

Brewfile で指定したすべてのパッケージをインストールする。

```bash
cd ~/dotfiles/homebrew
brew bundle
```

### パッケージの確認と削除

Brewfile にあるパッケージと Mac にインストール済みのパッケージを比較する。

```bash
# 未インストールのパッケージをリスト表示
brew bundle cleanup

# 未インストールのパッケージを削除（確認ダイアログ付き）
brew bundle cleanup --force
```

### アップデート

```bash
brew update
brew upgrade --cask --greedy
brew bundle
```

## zsh

シェル設定をセットアップする。

```bash
# シンボリックリンクを作成
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

# 設定を読み込む
source ~/.zshrc
```

## powerline-shell

ターミナルのプロンプトをカスタマイズする。

### 前提条件

- Homebrew で `font-hackgen` がインストール済みであること
- `git config user.name` が設定済みであること（`.config/zsh/env.zsh` で定義可能）

### セットアップ

1. **フォントをセット** (iTerm2 の場合)

   ```
   Preferences -> Profiles -> Text -> Font
   → 「HackGen35」を選択、font size は 16
   ```

2. **powerline-shell をインストール**

   ```bash
   git clone https://github.com/b-ryan/powerline-shell
   cd powerline-shell
   python3 setup.py install
   ```

3. **設定ファイルをリンク**

   ```bash
   mkdir -p ~/.config/powerline-shell
   ln -sf ~/dotfiles/powerline-shell/config.json ~/.config/powerline-shell/config.json
   ```

## エディタ

### VSCode / Cursor

設定ファイルをインストールスクリプト経由で反映する。

```bash
# VSCode
cd ~/dotfiles/vscode
bash install.sh

# Cursor
cd ~/dotfiles/cursor
bash install.sh
```

### Raycast

Raycast アプリの import 機能から設定ファイルを読み込む。

## Ruby

Ruby 関連のツール設定を目的ごとにディレクトリ分けして管理している。

- [ruby-lsp](ruby/ruby-lsp/README.md) - Language Server Protocol
- [rubocop](ruby/rubocop/README.md) - コード品質チェック
- [solargraph](ruby/solargraph/README.md) - 静的解析とコード補完

## AI エージェント共通設定

Cursor、Claude Code、Copilot、Codex CLI 向けのルール定義を統一管理する。

### 概要

- ソースコード：`agents/` 配下の `rulesync.jsonc` と `.rulesync/`
- ビルドツール：[Rulesync](https://github.com/dyoshikawa/rulesync)

### インストール

```bash
# Rulesync をインストール
npm install -g rulesync
# または
brew install rulesync

# ルール定義を生成してリンク
bash ~/dotfiles/agents/install.sh
```

このスクリプトにより、`~/.cursor` と `~/.claude` へシンボリックリンクが作成される。

## その他

プロジェクト固有のセットアップが必要な場合は、各ディレクトリの README を参照すること。
