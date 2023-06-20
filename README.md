# dotfiles

## Homebrew

Homebrew をインストール

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

各種パッケージをインストール

```shell
cd .config/homebrew
brew bundle
```

## .zshrc

シンボリックリンクを作成

```shell
ln -sf ~/dotfiles/.config/zsh/zshrc ~/.zshrc
```

設定内容を読み込む

```shell
source ~/.zshrc
```

## Raycast

import 機能で設定ファイルを読み込む
