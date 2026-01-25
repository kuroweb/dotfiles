---
name: tdd-workflow
description: 新機能の作成、バグ修正、コードリファクタリング時にこのスキルを使用。ユニット、インテグレーション、E2Eテストを含む80%以上のカバレッジでテスト駆動開発を強制。
---

# テスト駆動開発ワークフロー

すべてのコード開発がTDD原則に従い、包括的なテストカバレッジを持つことを保証するスキル。

## アクティベーションタイミング

- 新機能や機能の作成時
- バグや問題の修正時
- 既存コードのリファクタリング時
- APIエンドポイントの追加時
- 新規コンポーネントの作成時

## コア原則

### 1. コードの前にテスト

常にテストを先に書き、テストをパスするコードを実装します。

### 2. カバレッジ要件

- 最低80%カバレッジ（ユニット + インテグレーション + E2E）
- すべてのエッジケースをカバー
- エラーシナリオをテスト
- 境界条件を検証

### 3. テストタイプ

#### ユニットテスト

- 個々の関数とユーティリティ
- コンポーネントロジック
- 純粋関数
- ヘルパーとユーティリティ

#### インテグレーションテスト

- APIエンドポイント
- データベース操作
- サービス間のインタラクション
- 外部API呼び出し

#### E2Eテスト（Playwright）

- クリティカルなユーザーフロー
- 完全なワークフロー
- ブラウザ自動化
- UIインタラクション

## TDDワークフローステップ

### ステップ1: ユーザージャーニーを書く

```
[役割]として、[アクション]したい、[利益]のために

例:
ユーザーとして、マーケットをセマンティック検索したい、
正確なキーワードなしでも関連するマーケットを見つけられるように。
```

### ステップ2: テストケースを生成

各ユーザージャーニーに対して包括的なテストケースを作成:

```typescript
describe('セマンティック検索', () => {
  it('クエリに関連するマーケットを返す', async () => {
    // テスト実装
  })

  it('空のクエリを適切に処理する', async () => {
    // エッジケースのテスト
  })

  it('Redis利用不可時にサブストリング検索にフォールバックする', async () => {
    // フォールバック動作のテスト
  })

  it('類似度スコアで結果をソートする', async () => {
    // ソートロジックのテスト
  })
})
```

### ステップ3: テスト実行（失敗するはず）

```bash
npm test
# テストは失敗するはず - まだ実装していないから
```

### ステップ4: コードを実装

テストをパスするための最小限のコードを書く:

```typescript
// テストに導かれた実装
export async function searchMarkets(query: string) {
  // ここに実装
}
```

### ステップ5: 再度テスト実行

```bash
npm test
# テストがパスするはず
```

### ステップ6: リファクタリング

テストをグリーンに保ちながらコード品質を改善:

- 重複を削除
- 命名を改善
- パフォーマンスを最適化
- 可読性を向上

### ステップ7: カバレッジを確認

```bash
npm run test:coverage
# 80%以上のカバレッジを確認
```

## テストパターン

### ユニットテストパターン（Jest/Vitest）

```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { Button } from './Button'

describe('Buttonコンポーネント', () => {
  it('正しいテキストでレンダリングする', () => {
    render(<Button>クリック</Button>)
    expect(screen.getByText('クリック')).toBeInTheDocument()
  })

  it('クリック時にonClickを呼び出す', () => {
    const handleClick = jest.fn()
    render(<Button onClick={handleClick}>クリック</Button>)

    fireEvent.click(screen.getByRole('button'))

    expect(handleClick).toHaveBeenCalledTimes(1)
  })

  it('disabledプロパティがtrueの時に無効化される', () => {
    render(<Button disabled>クリック</Button>)
    expect(screen.getByRole('button')).toBeDisabled()
  })
})
```

### APIインテグレーションテストパターン

```typescript
import { NextRequest } from 'next/server'
import { GET } from './route'

describe('GET /api/markets', () => {
  it('マーケットを正常に返す', async () => {
    const request = new NextRequest('http://localhost/api/markets')
    const response = await GET(request)
    const data = await response.json()

    expect(response.status).toBe(200)
    expect(data.success).toBe(true)
    expect(Array.isArray(data.data)).toBe(true)
  })

  it('クエリパラメータをバリデートする', async () => {
    const request = new NextRequest('http://localhost/api/markets?limit=invalid')
    const response = await GET(request)

    expect(response.status).toBe(400)
  })

  it('データベースエラーを適切に処理する', async () => {
    // データベース障害をモック
    const request = new NextRequest('http://localhost/api/markets')
    // エラーハンドリングをテスト
  })
})
```

### E2Eテストパターン（Playwright）

```typescript
import { test, expect } from '@playwright/test'

test('ユーザーがマーケットを検索・フィルタできる', async ({ page }) => {
  // マーケットページに移動
  await page.goto('/')
  await page.click('a[href="/markets"]')

  // ページ読み込みを確認
  await expect(page.locator('h1')).toContainText('Markets')

  // マーケットを検索
  await page.fill('input[placeholder="Search markets"]', 'election')

  // デバウンスと結果を待機
  await page.waitForTimeout(600)

  // 検索結果の表示を確認
  const results = page.locator('[data-testid="market-card"]')
  await expect(results).toHaveCount(5, { timeout: 5000 })

  // 結果に検索語が含まれることを確認
  const firstResult = results.first()
  await expect(firstResult).toContainText('election', { ignoreCase: true })

  // ステータスでフィルタ
  await page.click('button:has-text("Active")')

  // フィルタ結果を確認
  await expect(results).toHaveCount(3)
})

test('ユーザーが新しいマーケットを作成できる', async ({ page }) => {
  // まずログイン
  await page.goto('/creator-dashboard')

  // マーケット作成フォームを入力
  await page.fill('input[name="name"]', 'Test Market')
  await page.fill('textarea[name="description"]', 'Test description')
  await page.fill('input[name="endDate"]', '2025-12-31')

  // フォームを送信
  await page.click('button[type="submit"]')

  // 成功メッセージを確認
  await expect(page.locator('text=Market created successfully')).toBeVisible()

  // マーケットページへのリダイレクトを確認
  await expect(page).toHaveURL(/\/markets\/test-market/)
})
```

## テストファイル構成

```
src/
├── components/
│   ├── Button/
│   │   ├── Button.tsx
│   │   ├── Button.test.tsx          # ユニットテスト
│   │   └── Button.stories.tsx       # Storybook
│   └── MarketCard/
│       ├── MarketCard.tsx
│       └── MarketCard.test.tsx
├── app/
│   └── api/
│       └── markets/
│           ├── route.ts
│           └── route.test.ts         # インテグレーションテスト
└── e2e/
    ├── markets.spec.ts               # E2Eテスト
    ├── trading.spec.ts
    └── auth.spec.ts
```

## 外部サービスのモック

### Supabaseモック

```typescript
jest.mock('@/lib/supabase', () => ({
  supabase: {
    from: jest.fn(() => ({
      select: jest.fn(() => ({
        eq: jest.fn(() => Promise.resolve({
          data: [{ id: 1, name: 'Test Market' }],
          error: null
        }))
      }))
    }))
  }
}))
```

### Redisモック

```typescript
jest.mock('@/lib/redis', () => ({
  searchMarketsByVector: jest.fn(() => Promise.resolve([
    { slug: 'test-market', similarity_score: 0.95 }
  ])),
  checkRedisHealth: jest.fn(() => Promise.resolve({ connected: true }))
}))
```

### OpenAIモック

```typescript
jest.mock('@/lib/openai', () => ({
  generateEmbedding: jest.fn(() => Promise.resolve(
    new Array(1536).fill(0.1) // 1536次元のモック埋め込み
  ))
}))
```

## テストカバレッジ確認

### カバレッジレポート実行

```bash
npm run test:coverage
```

### カバレッジ閾値

```json
{
  "jest": {
    "coverageThresholds": {
      "global": {
        "branches": 80,
        "functions": 80,
        "lines": 80,
        "statements": 80
      }
    }
  }
}
```

## 一般的なテストミスを避ける

### ❌ 間違い: 実装詳細をテスト

```typescript
// 内部状態をテストしない
expect(component.state.count).toBe(5)
```

### ✅ 正しい: ユーザーに見える動作をテスト

```typescript
// ユーザーに見えるものをテスト
expect(screen.getByText('Count: 5')).toBeInTheDocument()
```

### ❌ 間違い: 脆いセレクタ

```typescript
// 壊れやすい
await page.click('.css-class-xyz')
```

### ✅ 正しい: セマンティックセレクタ

```typescript
// 変更に強い
await page.click('button:has-text("Submit")')
await page.click('[data-testid="submit-button"]')
```

### ❌ 間違い: テスト分離なし

```typescript
// テストが互いに依存
test('ユーザーを作成', () => { /* ... */ })
test('同じユーザーを更新', () => { /* 前のテストに依存 */ })
```

### ✅ 正しい: 独立したテスト

```typescript
// 各テストが独自のデータを設定
test('ユーザーを作成', () => {
  const user = createTestUser()
  // テストロジック
})

test('ユーザーを更新', () => {
  const user = createTestUser()
  // 更新ロジック
})
```

## 継続的テスト

### 開発中のウォッチモード

```bash
npm test -- --watch
# ファイル変更時にテストが自動実行
```

### Pre-Commitフック

```bash
# 毎コミット前に実行
npm test && npm run lint
```

### CI/CD統合

```yaml
# GitHub Actions
- name: テスト実行
  run: npm test -- --coverage
- name: カバレッジアップロード
  uses: codecov/codecov-action@v3
```

## ベストプラクティス

1. **テストを先に書く** - 常にTDD
2. **1テスト1アサート** - 単一の動作に集中
3. **説明的なテスト名** - テスト対象を説明
4. **Arrange-Act-Assert** - 明確なテスト構造
5. **外部依存関係をモック** - ユニットテストを分離
6. **エッジケースをテスト** - null、undefined、空、大量
7. **エラーパスをテスト** - ハッピーパスだけでなく
8. **テストを高速に** - ユニットテストは各50ms以下
9. **テスト後にクリーンアップ** - 副作用なし
10. **カバレッジレポートを確認** - ギャップを特定

## 成功メトリクス

- 80%以上のコードカバレッジ達成
- すべてのテストがパス（グリーン）
- スキップ・無効化されたテストなし
- 高速なテスト実行（ユニットテスト30秒以内）
- E2Eテストがクリティカルなユーザーフローをカバー
- テストが本番前にバグを捕捉

---

**重要**: テストはオプションではありません。自信を持ったリファクタリング、迅速な開発、本番の信頼性を可能にするセーフティネットです。
