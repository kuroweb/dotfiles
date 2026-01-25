# Evalハーネススキル

Claude Codeセッション用の正式な評価フレームワークで、評価駆動開発（EDD）の原則を実装します。

## 思想

評価駆動開発はevalを「AI開発の単体テスト」として扱います:
- 実装前に期待される動作を定義
- 開発中に継続的にevalを実行
- 各変更でリグレッションを追跡
- 信頼性測定にpass@kメトリクスを使用

## Evalタイプ

### ケイパビリティEval
Claudeが以前できなかったことができるようになったかテスト:
```markdown
[CAPABILITY EVAL: feature-name]
Task: Claudeが達成すべきことの説明
Success Criteria:
  - [ ] 基準1
  - [ ] 基準2
  - [ ] 基準3
Expected Output: 期待される結果の説明
```

### リグレッションEval
変更が既存機能を壊さないことを確認:
```markdown
[REGRESSION EVAL: feature-name]
Baseline: SHAまたはチェックポイント名
Tests:
  - existing-test-1: PASS/FAIL
  - existing-test-2: PASS/FAIL
  - existing-test-3: PASS/FAIL
Result: X/Y passed (previously Y/Y)
```

## グレーダータイプ

### 1. コードベースグレーダー
コードを使用した決定論的チェック:
```bash
# ファイルに期待されるパターンが含まれるかチェック
grep -q "export function handleAuth" src/auth.ts && echo "PASS" || echo "FAIL"

# テストがパスするかチェック
npm test -- --testPathPattern="auth" && echo "PASS" || echo "FAIL"

# ビルドが成功するかチェック
npm run build && echo "PASS" || echo "FAIL"
```

### 2. モデルベースグレーダー
Claudeを使用してオープンエンドな出力を評価:
```markdown
[MODEL GRADER PROMPT]
以下のコード変更を評価してください:
1. 述べられた問題を解決しているか？
2. 構造が適切か？
3. エッジケースが処理されているか？
4. エラーハンドリングは適切か？

Score: 1-5 (1=悪い, 5=優秀)
Reasoning: [説明]
```

### 3. 人間グレーダー
手動レビュー用にフラグ:
```markdown
[HUMAN REVIEW REQUIRED]
Change: 変更内容の説明
Reason: 人間レビューが必要な理由
Risk Level: LOW/MEDIUM/HIGH
```

## メトリクス

### pass@k
「k回の試行で少なくとも1回成功」
- pass@1: 初回試行成功率
- pass@3: 3回以内の成功率
- 一般的なターゲット: pass@3 > 90%

### pass^k
「k回すべて成功」
- より高い信頼性の基準
- pass^3: 3回連続成功
- クリティカルパスに使用

## Evalワークフロー

### 1. 定義（コーディング前）
```markdown
## EVAL DEFINITION: feature-xyz

### Capability Evals
1. 新規ユーザーアカウントを作成できる
2. メールフォーマットを検証できる
3. パスワードを安全にハッシュ化できる

### Regression Evals
1. 既存のログインが引き続き動作する
2. セッション管理が変更されていない
3. ログアウトフローが維持されている

### Success Metrics
- capability evalでpass@3 > 90%
- regression evalでpass^3 = 100%
```

### 2. 実装
定義されたevalをパスするコードを書く。

### 3. 評価
```bash
# capability evalを実行
[各capability evalを実行し、PASS/FAILを記録]

# regression evalを実行
npm test -- --testPathPattern="existing"

# レポート生成
```

### 4. レポート
```markdown
EVAL REPORT: feature-xyz
========================

Capability Evals:
  create-user:     PASS (pass@1)
  validate-email:  PASS (pass@2)
  hash-password:   PASS (pass@1)
  Overall:         3/3 passed

Regression Evals:
  login-flow:      PASS
  session-mgmt:    PASS
  logout-flow:     PASS
  Overall:         3/3 passed

Metrics:
  pass@1: 67% (2/3)
  pass@3: 100% (3/3)

Status: READY FOR REVIEW
```

## 統合パターン

### 実装前
```
/eval define feature-name
```
`.claude/evals/feature-name.md` にeval定義ファイルを作成

### 実装中
```
/eval check feature-name
```
現在のevalを実行しステータスを報告

### 実装後
```
/eval report feature-name
```
完全なevalレポートを生成

## Evalストレージ

プロジェクト内にevalを保存:
```
.claude/
  evals/
    feature-xyz.md      # Eval定義
    feature-xyz.log     # Eval実行履歴
    baseline.json       # リグレッションベースライン
```

## ベストプラクティス

1. **コーディング前にevalを定義** - 成功基準について明確に考えることを強制
2. **頻繁にevalを実行** - リグレッションを早期に発見
3. **pass@kを時間経過で追跡** - 信頼性トレンドを監視
4. **可能な限りコードグレーダーを使用** - 決定論的 > 確率的
5. **セキュリティは人間レビュー** - セキュリティチェックを完全に自動化しない
6. **evalを高速に保つ** - 遅いevalは実行されない
7. **evalをコードとバージョン管理** - evalは一級市民の成果物

## 例: 認証の追加

```markdown
## EVAL: add-authentication

### Phase 1: 定義 (10分)
Capability Evals:
- [ ] ユーザーがメール/パスワードで登録できる
- [ ] ユーザーが有効な認証情報でログインできる
- [ ] 無効な認証情報が適切なエラーで拒否される
- [ ] セッションがページリロード後も維持される
- [ ] ログアウトでセッションがクリアされる

Regression Evals:
- [ ] パブリックルートが引き続きアクセス可能
- [ ] APIレスポンスが変更されていない
- [ ] データベーススキーマが互換性を維持

### Phase 2: 実装 (可変)
[コードを書く]

### Phase 3: 評価
Run: /eval check add-authentication

### Phase 4: レポート
EVAL REPORT: add-authentication
==============================
Capability: 5/5 passed (pass@3: 100%)
Regression: 3/3 passed (pass^3: 100%)
Status: SHIP IT
```
