# dotfiles<!-- omit in toc -->

macOS の開発環境設定を管理するリポジトリ

## 目次<!-- omit in toc -->

- [クイックスタート](#クイックスタート)
- [Homebrew](#homebrew)
  - [インストール](#インストール)
  - [パッケージをまとめてインストール](#パッケージをまとめてインストール)
  - [パッケージの確認と削除](#パッケージの確認と削除)
  - [アップデート](#アップデート)
- [zsh](#zsh)
- [powerline-shell](#powerline-shell)
  - [前提条件](#前提条件)
  - [セットアップ](#セットアップ)
- [エディタ](#エディタ)
  - [VSCode / Cursor](#vscode--cursor)
  - [Neovim](#neovim)
- [Raycast](#raycast)
- [Ruby](#ruby)
- [AIエージェント](#aiエージェント)
- [その他](#その他)

## クイックスタート

```bash
# 1. リポジトリをクローン
git clone https://${GIT_USER_PRIVATE}:${GIT_TOKEN_PRIVATE}@github.com/${GIT_USER_PRIVATE}/dotfiles ~/dotfiles

# 2. Homebrew をインストール（未インストール時）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. パッケージをインストール
cd ~/dotfiles/homebrew
brew bundle

# 4. zsh を設定
bash ~/dotfiles/zsh/install.sh
source ~/.zshrc
```

詳細なセットアップは以下のセクションを参照すること

## Homebrew

パッケージマネージャーとしての Homebrew をセットアップする

### インストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### パッケージをまとめてインストール

Brewfile で指定したすべてのパッケージをインストールする

```bash
cd ~/dotfiles/homebrew
brew bundle
```

### パッケージの確認と削除

Brewfile にあるパッケージと Mac にインストール済みのパッケージを比較する

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

シェル設定をセットアップする

```bash
bash ~/dotfiles/zsh/install.sh
source ~/.zshrc
```

## powerline-shell

ターミナルのプロンプトをカスタマイズする

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

設定ファイルをインストールスクリプト経由で反映する

```bash
# VSCode
bash ~/dotfiles/vscode/install.sh

# Cursor
bash ~/dotfiles/cursor/install.sh
```

### Neovim

設定ファイルをインストールスクリプト経由で反映する

```bash
bash ~/dotfiles/nvim/install.sh
```

## Raycast

ランチャーアプリの設定を管理する

Raycast アプリの import 機能から設定ファイルを読み込む

## Ruby

Ruby 関連のツール設定を目的ごとにディレクトリ分けして管理している

| ツール | 説明 |
|--------|------|
| [ruby-lsp](ruby/ruby-lsp/README.md) | Language Server Protocol |
| [rubocop](ruby/rubocop/README.md) | コード品質チェック |
| [solargraph](ruby/solargraph/README.md) | 静的解析とコード補完 |

## AIエージェント

Cursor、Claude Code、Copilot、Codex CLI 向けのルール定義を統一管理する

以下のスクリプトで `~/.cursor` と `~/.claude` へシンボリックリンクを作成する

```bash
bash ~/dotfiles/agents/install.sh
```

| 項目 | 内容 |
|------|------|
| ソースコード | `agents/` 配下の `rulesync.jsonc` と `.rulesync/` |
| ビルドツール | [Rulesync](https://github.com/dyoshikawa/rulesync) |

## その他

プロジェクト固有のセットアップが必要な場合は、各ディレクトリの README を参照すること
