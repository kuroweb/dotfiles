# 検証ループスキル

Claude Codeセッション用の包括的な検証システム。

## 使用タイミング

このスキルを呼び出すタイミング:

- 機能や重要なコード変更の完了後
- PR作成前
- 品質ゲートのパスを確認したい時
- リファクタリング後

## 検証フェーズ

### フェーズ1: ビルド検証

```bash
# プロジェクトがビルドできるかチェック
npm run build 2>&1 | tail -20
# または
pnpm build 2>&1 | tail -20
```

ビルドが失敗した場合、続行前にSTOPして修正。

### フェーズ2: 型チェック

```bash
# TypeScriptプロジェクト
npx tsc --noEmit 2>&1 | head -30

# Pythonプロジェクト
pyright . 2>&1 | head -30
```

すべての型エラーを報告。続行前にクリティカルなものを修正。

### フェーズ3: Lintチェック

```bash
# JavaScript/TypeScript
npm run lint 2>&1 | head -30

# Python
ruff check . 2>&1 | head -30
```

### フェーズ4: テストスイート

```bash
# カバレッジ付きでテスト実行
npm run test -- --coverage 2>&1 | tail -50

# カバレッジ閾値をチェック
# ターゲット: 最低80%
```

報告:

- 合計テスト数: X
- パス: X
- 失敗: X
- カバレッジ: X%

### フェーズ5: セキュリティスキャン

```bash
# シークレットをチェック
grep -rn "sk-" --include="*.ts" --include="*.js" . 2>/dev/null | head -10
grep -rn "api_key" --include="*.ts" --include="*.js" . 2>/dev/null | head -10

# console.logをチェック
grep -rn "console.log" --include="*.ts" --include="*.tsx" src/ 2>/dev/null | head -10
```

### フェーズ6: Diffレビュー

```bash
# 変更内容を表示
git diff --stat
git diff HEAD~1 --name-only
```

各変更ファイルをレビュー:

- 意図しない変更
- 欠落しているエラーハンドリング
- 潜在的なエッジケース

## 出力形式

すべてのフェーズ実行後、検証レポートを生成:

```
VERIFICATION REPORT
==================

Build:     [PASS/FAIL]
Types:     [PASS/FAIL] (Xエラー)
Lint:      [PASS/FAIL] (X警告)
Tests:     [PASS/FAIL] (X/Yパス、Z%カバレッジ)
Security:  [PASS/FAIL] (X件の問題)
Diff:      [Xファイル変更]

Overall:   [READY/NOT READY] for PR

修正が必要な問題:
1. ...
2. ...
```

## 継続モード

長いセッションでは、15分ごとまたは大きな変更後に検証を実行:

```markdown
メンタルチェックポイントを設定:
- 各関数完了後
- コンポーネント完成後
- 次のタスクに移る前

実行: /verify
```

## フックとの統合

このスキルはPostToolUseフックを補完しますが、より深い検証を提供します。
フックは問題を即座に捕捉、このスキルは包括的なレビューを提供。
