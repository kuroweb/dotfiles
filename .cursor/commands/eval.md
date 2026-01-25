# 評価コマンド

評価駆動開発ワークフローを管理します。

## 使用方法

`/eval [define|check|report|list] [feature-name]`

## 評価の定義

`/eval define feature-name`

新しい評価定義を作成:

1. 以下のテンプレートで `.claude/evals/feature-name.md` を作成:

    ```markdown
    ## 評価: feature-name
    作成日: $(date)

    ### 機能評価
    - [ ] [機能1の説明]
    - [ ] [機能2の説明]

    ### 回帰評価
    - [ ] [既存の動作1が引き続き動作する]
    - [ ] [既存の動作2が引き続き動作する]

    ### 成功基準
    - 機能評価でpass@3 > 90%
    - 回帰評価でpass^3 = 100%
    ```

2. ユーザーに具体的な基準を入力するよう促す

## 評価のチェック

`/eval check feature-name`

機能の評価を実行:

1. `.claude/evals/feature-name.md` から評価定義を読み込み
2. 各機能評価について:
   - 基準の検証を試行
   - PASS/FAILを記録
   - `.claude/evals/feature-name.log` に試行を記録
3. 各回帰評価について:
   - 関連するテストを実行
   - ベースラインと比較
   - PASS/FAILを記録
4. 現在のステータスを報告:

    ```
    評価チェック: feature-name
    ========================
    機能: X/Y 合格
    回帰: X/Y 合格
    ステータス: 進行中 / 準備完了
    ```

## 評価レポート

`/eval report feature-name`

包括的な評価レポートを生成:

```
評価レポート: feature-name
=========================
生成日: $(date)

機能評価
----------------
[eval-1]: PASS (pass@1)
[eval-2]: PASS (pass@2) - リトライが必要だった
[eval-3]: FAIL - 備考を参照

回帰評価
----------------
[test-1]: PASS
[test-2]: PASS
[test-3]: PASS

メトリクス
-------
機能 pass@1: 67%
機能 pass@3: 100%
回帰 pass^3: 100%

備考
-----
[問題、エッジケース、または観察事項]

推奨
--------------
[リリース / 追加作業が必要 / ブロック]
```

## 評価の一覧

`/eval list`

すべての評価定義を表示:

```
評価定義
================
feature-auth      [3/5 合格] 進行中
feature-search    [5/5 合格] 準備完了
feature-export    [0/4 合格] 未開始
```

## 引数

$ARGUMENTS:

- `define <name>` - 新しい評価定義を作成
- `check <name>` - 評価を実行してチェック
- `report <name>` - 完全なレポートを生成
- `list` - すべての評価を表示
- `clean` - 古い評価ログを削除（最新10回の実行を保持）
