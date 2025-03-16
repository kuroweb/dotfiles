# Solargraph<!-- omit in toc -->

- VSCodeでSolargraphによるコード補完と定義ジャンブを動作させるために作成したもの

## TOC<!-- omit in toc -->

- [Required](#required)
- [Setup](#setup)

## Required

- rbenv
- VSCode Extension:
  - [castwide.solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph)

## Setup

- `env`ファイルでバージョン調整

  ```bash
  $ vi env.sh
  ```

- gemをインストール

  ```bash
  $ bash install.sh
  ```

- VSCodeに[castwide.solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph)をインストール

- SolargraphをVSCodeで実行したいプロジェクトで`.vscode/settings.json`に以下の内容を追記

  ```json
  {
    "solargraph.commandPath": "/path/to/dotfiles/ruby/solargraph/bin/solargraph",
    "solargraph.useBundler": false,
    "solargraph.diagnostics": false, // lintはrubocop gemと拡張機能で実施するので無効化
    "solargraph.definitions": true,
    "solargraph.completion": true,
    "solargraph.references": true,
    "solargraph.checkGemVersion": false
  }
  ```
