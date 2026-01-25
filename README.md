# dotfiles

- 本リポジトリをクローン

  ```bash
  git clone https://${GIT_USER_PRIVATE}:${GIT_TOKEN_PRIVATE}@github.com/${GIT_USER_PRIVATE}/dotfiles ~/dotfiles
  ```

## Homebrew

- Homebrew をインストール

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- 各種パッケージをインストール

  ```bash
  cd homebrew
  brew bundle
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
  ln -sf ~/dotfiles/powerline-shell/config.json ~/.config/powerline-shell/config.json
  ```

  > ※`git config user.name`が未設定だとpowerline-shellのエラーメッセージが表示されるため、予め`.config/zsh/env.zsh`でユーザー名を定義しておくこと

## zsh

- シンボリックリンクを作成

  ```bash
  ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
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
  cd ~/dotfiles/vscode
  bash install.sh

  # Cursor
  cd ~/dotfiles/cursor
  bash install.sh
  ```

## Ruby

- `ruby/*`配下に目的ごとにディレクトリを切ってgemをインストールできるようにしている
  - [ruby-lsp](ruby/ruby-lsp/README.md)
  - [rubocop](ruby/rubocop/README.md)
  - [solargraph](ruby/solargraph/README.md)

## Cursor

- プロジェクトで共通のCursor設定を使用する場合、以下のスクリプトを実行する

  ```bash
  bash ~/path/to/dotfiles/.cursor/install.sh ~/path/to/project
  ```
