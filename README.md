# dotfiles<!-- omit in toc -->

macOS の開発環境設定を管理するリポジトリ

## 目次<!-- omit in toc -->

- [クイックスタート](#クイックスタート)
- [Homebrew](#homebrew)
- [シェル](#シェル)
  - [zsh](#zsh)
  - [powerline-shell](#powerline-shell)
- [エディタ](#エディタ)
  - [Cursor](#cursor)
  - [VSCode](#vscode)
  - [Neovim](#neovim)
- [rbenv](#rbenv)
- [Ruby Tools](#ruby-tools)
- [Utility](#utility)
  - [Raycast](#raycast)

## クイックスタート

- リポジトリをクローン

  ```bash
  git clone https://${GIT_USER_PRIVATE}:${GIT_TOKEN_PRIVATE}@github.com/${GIT_USER_PRIVATE}/dotfiles ~/dotfiles
  ```

- Homebrew をインストール（未インストール時）

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- パッケージをインストール

  ```bash
  cd ~/dotfiles/homebrew
  brew bundle
  ```

- zsh を設定

  ```bash
  bash ~/dotfiles/zsh/install.sh
  source ~/.zshrc
  ```

- 👉詳細なセットアップは以下のセクションを参照すること

## Homebrew

- インストール

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- パッケージをまとめてインストール

  ```bash
  cd ~/dotfiles/homebrew
  brew bundle
  ```

- パッケージの確認と削除

  ```bash
  # 未インストールのパッケージをリスト表示
  brew bundle cleanup

  # 未インストールのパッケージを削除（確認ダイアログ付き）
  brew bundle cleanup --force
  ```

- アップデート

  ```bash
  brew update
  brew upgrade --cask --greedy
  brew bundle
  ```

## シェル

### zsh

- シェル設定をセットアップする

  ```bash
  bash ~/dotfiles/zsh/install.sh
  source ~/.zshrc
  ```

### powerline-shell

- ターミナルのプロンプトをカスタマイズする

**前提条件:**

- Homebrew で `font-hackgen` がインストール済みであること
- `git config user.name` が設定済みであること（`.config/zsh/env.zsh` で定義可能）

**セットアップ:**

- フォントをセット (iTerm2 の場合)

  ```
  Preferences -> Profiles -> Text -> Font
  → 「HackGen35」を選択、font size は 16
  ```

- powerline-shell をインストール

  ```bash
  git clone https://github.com/b-ryan/powerline-shell
  cd powerline-shell
  python3 setup.py install
  ```

- 設定ファイルをリンク

  ```bash
  mkdir -p ~/.config/powerline-shell
  ln -sf ~/dotfiles/powerline-shell/config.json ~/.config/powerline-shell/config.json
  ```

## エディタ

### Cursor

- セットアップスクリプトを実行する

  ```bash
  bash ~/dotfiles/cursor/install.sh
  ```

### VSCode

- セットアップスクリプトを実行する

  ```bash
  bash ~/dotfiles/vscode/install.sh
  ```

### Neovim

- セットアップスクリプトを実行する

  ```bash
  bash ~/dotfiles/nvim/install.sh
  ```

## rbenv

- Ruby 3.2.2 をインストール

  ```bash
  rbenv install 3.2.2
  rbenv global 3.2.2
  ```

- インストールされているバージョンを確認

  ```bash
  rbenv versions
  ```

## Ruby Tools

- Ruby 関連のツール設定を目的ごとにディレクトリ分けして管理している

  | ツール | 説明 |
  | --- | --- |
  | [ruby-lsp](ruby/ruby-lsp/README.md) | Language Server Protocol |
  | [rubocop](ruby/rubocop/README.md) | コード品質チェック |
  | [solargraph](ruby/solargraph/README.md) | 静的解析とコード補完 |

## Utility

### Raycast

- Raycast アプリの import 機能から設定ファイルを読み込む
