# Rubocop<!-- omit in toc -->

- 古いバージョンのRuboCopでVSCode拡張を動作させるために作成したもの

## TOC<!-- omit in toc -->

- [Required](#required)
- [Setup](#setup)

## Required

- rbenv
- VSCode Extension:
  - [misogi.ruby-rubocop](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop)

## Setup

- `env`ファイルでバージョン調整

  ```bash
  $ vi env
  ```

- gemをインストール

  ```bash
  $ bash install.sh
  ```

- VSCodeに[misogi.ruby-rubocop](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop)をインストール

- RuboCopをVSCodeで実行したいプロジェクトで`.vscode/settings.json`に以下の内容を追記

  ```json
  {
    "ruby.rubocop.executePath": "/path/to/dotfiles/ruby/rubocop/bin/",
    "ruby.rubocop.configFilePath": "/path/to/.rubocop.yml",
    "[ruby]": {
      "editor.defaultFormatter": "misogi.ruby-rubocop"
    }
  }
  ```
