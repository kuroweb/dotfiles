# dotfiles

## Homebrew

Homebrew をインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

各種パッケージをインストール

```bash
cd .config/homebrew
brew bundle
```

差分チェック

```bash
brew bundle cleanup
```

Brewfileの内容で更新

```bash
brew bundle cleanup --force
```

## .zshrc

シンボリックリンクを作成

```bash
ln -sf ~/dotfiles/.config/zsh/zshrc ~/.zshrc
```

設定内容を読み込む

```bash
source ~/.zshrc
```

## Raycast

import 機能で設定ファイルを読み込む
