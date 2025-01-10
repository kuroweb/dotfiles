# dotfiles

## Homebrew

- Homebrew をインストール

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- 各種パッケージをインストール

  ```bash
  cd .config/homebrew
  brew bundle --no-upgrade
  ```

- Macにインストール済みのパッケージとBrewfileにあるパッケージを比較して、未インストールのパッケージのリストを表示

  ```bash
  brew bundle cleanup
  ```

- Macにインストール済みのパッケージとBrewfileにあるパッケージを比較して、未インストールのパッケージをMacから削除する

  ```bash
  brew bundle cleanup --force
  ```

### Tips

- アグレッシブにパッケージアップデートする

  ```bash
  brew update
  brew upgrade --cask --greedy
  brew bundle
  ```

## powerline-shell

> ※ 予め、Homebrewで `font-hackgen` をインストール済みであること

- iterm2でフォントを変更

  ```
  Preferences -> Profiles -> Text -> Font
  #=> 「HackGen35」を選択
  #=> font sizeで16を選択
  ```

- powerline-shellをインストール

  ```bash
  git clone https://github.com/b-ryan/powerline-shell
  cd powerline-shell
  python3 setup.py install
  ```

- 設定ファイルのシンボリックリンクを作成

  ```bash
  mkdir ~/.config/powerline-shell
  ln -sf ~/dotfiles/.config/powerline-shell/config.json ~/.config/powerline-shell/config.json
  ```

  > ※`git config user.name`が未設定だとpowerline-shellのエラーメッセージが表示されるため、予め`.config/zsh/env.zsh`でユーザー名を定義しておくこと

## zsh

- シンボリックリンクを作成

```bash
ln -sf ~/dotfiles/.config/zsh/zshrc ~/.zshrc
```

- 設定内容を読み込む

  ```bash
  source ~/.zshrc
  ```

## Raycast

- import 機能で設定ファイルを読み込む

## VSCode (Cursor)

- 設定ファイルを反映する

  ```bash
  # VSCode
  cd ~/dotfiles/.config/vscode
  bash install.sh

  # Cursor
  cd ~/dotfiles/.config/cursor
  bash install.sh
  ```
