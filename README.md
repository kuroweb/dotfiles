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

Macにインストール済みのパッケージとBrewfileにあるパッケージを比較して、未インストールのパッケージのリストを表示

```bash
brew bundle cleanup
```

Macにインストール済みのパッケージとBrewfileにあるパッケージを比較して、未インストールのパッケージをMacから削除する

```bash
brew bundle cleanup --force
```

## powerline-shell

※ 予め、Homebrewで `Ricty for Powerline` をインストール済みであること

```bash
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
```

iterm2でフォントを変更

```
Preferences -> Profiles -> Text -> Font
#=> 「Ricty for Powerline」を選択
#=> font sizeで16を選択
```

powerline-shellをインストール

```bash
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
python3 setup.py install
```

設定ファイルのシンボリックリンクを作成

```bash
mkdir ~/.config/powerline-shell
ln -sf ~/dotfiles/.config/powerline-shell/config.json ~/.config/powerline-shell/config.json
```

## zsh

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
