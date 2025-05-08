# Ruby LSP<!-- omit in toc -->

- VSCodeで[Shopify.ruby-lsp](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp)を利用するためのgemをインストールする

## TOC<!-- omit in toc -->

- [Required](#required)
- [Setup](#setup)

## Required

- VSCode Extension:
  - [Shopify.ruby-lsp](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp)

## Setup

- gemをインストール

  ```bash
  $ bash install.sh
  ```

- VSCodeに[Shopify.ruby-lsp](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp)をインストール

- Ruby LSPをVSCodeで実行したいプロジェクトで`.vscode/settings.json`に以下の内容を追記

  ```json
  {
    "rubyLsp.bundleGemfile": "/path/to/dotfiles/ruby/ruby-lsp/Gemfile"
  }
  ```
