---
description: Playwrightを使用してエンドツーエンドテストを生成・実行します。テストジャーニーを作成し、テストを実行し、スクリーンショット/ビデオ/トレースをキャプチャし、成果物をアップロードします。
---

# E2Eコマンド

このコマンドは**e2e-runner**エージェントを呼び出し、Playwrightを使用してエンドツーエンドテストの生成、保守、実行を行います。

## このコマンドの機能

1. **テストジャーニーの生成** - ユーザーフローのPlaywrightテストを作成
2. **E2Eテストの実行** - 複数のブラウザでテストを実行
3. **成果物のキャプチャ** - 失敗時のスクリーンショット、ビデオ、トレース
4. **結果のアップロード** - HTMLレポートとJUnit XML
5. **不安定なテストの特定** - 不安定なテストを隔離

## 使用するタイミング

`/e2e`を使用する場合:

- 重要なユーザージャーニーのテスト（ログイン、取引、決済）
- マルチステップフローがエンドツーエンドで動作することを確認
- UIインタラクションとナビゲーションのテスト
- フロントエンドとバックエンド間の統合を検証
- 本番デプロイの準備

## 動作の仕組み

e2e-runnerエージェントは以下を行います:

1. **ユーザーフローを分析**し、テストシナリオを特定
2. **Page Object Modelパターンを使用してPlaywrightテストを生成**
3. **複数のブラウザ（Chrome、Firefox、Safari）でテストを実行**
4. **失敗をスクリーンショット、ビデオ、トレースでキャプチャ**
5. **結果と成果物を含むレポートを生成**
6. **不安定なテストを特定**し、修正を推奨

## 使用例

```
ユーザー: /e2e マーケット検索と表示フローをテスト

エージェント (e2e-runner):
# E2Eテスト生成: マーケット検索と表示フロー

## 特定されたテストシナリオ

**ユーザージャーニー:** マーケット検索 → 結果表示 → マーケットをクリック → 詳細表示

**テストカバレッジ:**
1. マーケットページに移動
2. セマンティック検索を実行
3. 検索結果を確認
4. 最初の結果をクリック
5. マーケット詳細ページがロードされることを確認
6. チャートがレンダリングされることを確認

## 生成されたテストコード

```typescript
// tests/e2e/markets/search-and-view.spec.ts
import { test, expect } from '@playwright/test'
import { MarketsPage } from '../../pages/MarketsPage'
import { MarketDetailsPage } from '../../pages/MarketDetailsPage'

test.describe('マーケット検索と表示フロー', () => {
  test('ユーザーはマーケットを検索して詳細を表示できる', async ({ page }) => {
    // 1. マーケットページに移動
    const marketsPage = new MarketsPage(page)
    await marketsPage.goto()

    // ページがロードされたことを確認
    await expect(page).toHaveTitle(/Markets/)
    await expect(page.locator('h1')).toContainText('Markets')

    // 2. セマンティック検索を実行
    await marketsPage.searchMarkets('election')

    // APIレスポンスを待機
    await page.waitForResponse(resp =>
      resp.url().includes('/api/markets/search') && resp.status() === 200
    )

    // 3. 検索結果を確認
    const marketCards = marketsPage.marketCards
    await expect(marketCards.first()).toBeVisible()
    const resultCount = await marketCards.count()
    expect(resultCount).toBeGreaterThan(0)

    // 検索結果のスクリーンショットを撮影
    await page.screenshot({ path: 'artifacts/search-results.png' })

    // 4. 最初の結果をクリック
    const firstMarketTitle = await marketCards.first().textContent()
    await marketCards.first().click()

    // 5. マーケット詳細ページがロードされることを確認
    await expect(page).toHaveURL(/\/markets\/[a-z0-9-]+/)

    const detailsPage = new MarketDetailsPage(page)
    await expect(detailsPage.marketName).toBeVisible()
    await expect(detailsPage.marketDescription).toBeVisible()

    // 6. チャートがレンダリングされることを確認
    await expect(detailsPage.priceChart).toBeVisible()

    // マーケット名が一致することを確認
    const detailsTitle = await detailsPage.marketName.textContent()
    expect(detailsTitle?.toLowerCase()).toContain(
      firstMarketTitle?.toLowerCase().substring(0, 20) || ''
    )

    // マーケット詳細のスクリーンショットを撮影
    await page.screenshot({ path: 'artifacts/market-details.png' })
  })

  test('結果がない検索では空の状態が表示される', async ({ page }) => {
    const marketsPage = new MarketsPage(page)
    await marketsPage.goto()

    // 存在しないマーケットを検索
    await marketsPage.searchMarkets('xyznonexistentmarket123456')

    // 空の状態を確認
    await expect(page.locator('[data-testid="no-results"]')).toBeVisible()
    await expect(page.locator('[data-testid="no-results"]')).toContainText(
      /no.*results|no.*markets/i
    )

    const marketCount = await marketsPage.marketCards.count()
    expect(marketCount).toBe(0)
  })

  test('検索をクリアしてすべてのマーケットを再表示できる', async ({ page }) => {
    const marketsPage = new MarketsPage(page)
    await marketsPage.goto()

    // 初期のマーケット数
    const initialCount = await marketsPage.marketCards.count()

    // 検索を実行
    await marketsPage.searchMarkets('trump')
    await page.waitForLoadState('networkidle')

    // フィルター後の結果を確認
    const filteredCount = await marketsPage.marketCards.count()
    expect(filteredCount).toBeLessThan(initialCount)

    // 検索をクリア
    await marketsPage.searchInput.clear()
    await page.waitForLoadState('networkidle')

    // すべてのマーケットが再表示されることを確認
    const finalCount = await marketsPage.marketCards.count()
    expect(finalCount).toBe(initialCount)
  })
})
```

## テストの実行

```bash
# 生成されたテストを実行
npx playwright test tests/e2e/markets/search-and-view.spec.ts

3つのワーカーを使用して3つのテストを実行中

  ✓  [chromium] › search-and-view.spec.ts:5:3 › ユーザーはマーケットを検索して詳細を表示できる (4.2s)
  ✓  [chromium] › search-and-view.spec.ts:52:3 › 結果がない検索では空の状態が表示される (1.8s)
  ✓  [chromium] › search-and-view.spec.ts:67:3 › 検索をクリアしてすべてのマーケットを再表示できる (2.9s)

  3件合格 (9.1s)

生成された成果物:
- artifacts/search-results.png
- artifacts/market-details.png
- playwright-report/index.html
```

## テストレポート

```
╔══════════════════════════════════════════════════════════════╗
║                    E2Eテスト結果                              ║
╠══════════════════════════════════════════════════════════════╣
║ ステータス:     ✅ 全テスト合格                               ║
║ 合計:      3テスト                                           ║
║ 合格:     3 (100%)                                           ║
║ 失敗:     0                                                  ║
║ 不安定:      0                                               ║
║ 所要時間:   9.1s                                             ║
╚══════════════════════════════════════════════════════════════╝

成果物:
📸 スクリーンショット: 2ファイル
📹 ビデオ: 0ファイル（失敗時のみ）
🔍 トレース: 0ファイル（失敗時のみ）
📊 HTMLレポート: playwright-report/index.html

レポートを表示: npx playwright show-report
```

✅ E2Eテストスイートはci/CDへの統合準備完了です！

```

## テスト成果物

テスト実行時に以下の成果物がキャプチャされます:

**すべてのテストで:**
- タイムラインと結果を含むHTMLレポート
- CI統合用のJUnit XML

**失敗時のみ:**
- 失敗時の状態のスクリーンショット
- テストのビデオ録画
- デバッグ用のトレースファイル（ステップバイステップのリプレイ）
- ネットワークログ
- コンソールログ

## 成果物の確認

```bash
# ブラウザでHTMLレポートを表示
npx playwright show-report

# 特定のトレースファイルを表示
npx playwright show-trace artifacts/trace-abc123.zip

# スクリーンショットはartifacts/ディレクトリに保存
open artifacts/search-results.png
```

## 不安定なテストの検出

テストが断続的に失敗する場合:

```
⚠️  不安定なテストを検出: tests/e2e/markets/trade.spec.ts

テストは10回中7回合格 (70%の合格率)

よくある失敗:
"要素 '[data-testid="confirm-btn"]' の待機がタイムアウト"

推奨される修正:
1. 明示的な待機を追加: await page.waitForSelector('[data-testid="confirm-btn"]')
2. タイムアウトを増やす: { timeout: 10000 }
3. コンポーネント内の競合状態をチェック
4. 要素がアニメーションで隠れていないか確認

隔離の推奨: 修正されるまでtest.fixme()としてマーク
```

## ブラウザ設定

テストはデフォルトで複数のブラウザで実行されます:

- ✅ Chromium（デスクトップChrome）
- ✅ Firefox（デスクトップ）
- ✅ WebKit（デスクトップSafari）
- ✅ モバイルChrome（オプション）

ブラウザを調整するには`playwright.config.ts`で設定してください。

## CI/CD統合

CIパイプラインに追加:

```yaml
# .github/workflows/e2e.yml
- name: Playwrightをインストール
  run: npx playwright install --with-deps

- name: E2Eテストを実行
  run: npx playwright test

- name: 成果物をアップロード
  if: always()
  uses: actions/upload-artifact@v3
  with:
    name: playwright-report
    path: playwright-report/
```

## PMX固有の重要フロー

PMXでは、これらのE2Eテストを優先してください:

**🔴 クリティカル（常に合格必須）:**

1. ユーザーがウォレットを接続できる
2. ユーザーがマーケットを閲覧できる
3. ユーザーがマーケットを検索できる（セマンティック検索）
4. ユーザーがマーケット詳細を表示できる
5. ユーザーが取引を行える（テスト資金で）
6. マーケットが正しく解決される
7. ユーザーが資金を引き出せる

**🟡 重要:**

1. マーケット作成フロー
2. ユーザープロファイルの更新
3. リアルタイム価格更新
4. チャートレンダリング
5. マーケットのフィルターとソート
6. モバイルレスポンシブレイアウト

## ベストプラクティス

**推奨:**

- ✅ メンテナビリティのためPage Object Modelを使用
- ✅ セレクターにはdata-testid属性を使用
- ✅ 任意のタイムアウトではなくAPIレスポンスを待機
- ✅ 重要なユーザージャーニーをエンドツーエンドでテスト
- ✅ mainにマージする前にテストを実行
- ✅ テスト失敗時は成果物を確認

**非推奨:**

- ❌ 脆いセレクターを使用（CSSクラスは変更される可能性がある）
- ❌ 実装の詳細をテスト
- ❌ 本番環境に対してテストを実行
- ❌ 不安定なテストを無視
- ❌ 失敗時の成果物レビューをスキップ
- ❌ すべてのエッジケースをE2Eでテスト（ユニットテストを使用）

## 重要な注意事項

**PMXでのクリティカル:**

- 実際のお金が関わるE2Eテストは、テストネット/ステージングでのみ実行すること
- 本番環境に対して取引テストを実行しないこと
- 金融テストには`test.skip(process.env.NODE_ENV === 'production')`を設定
- 少額のテスト資金のみを持つテストウォレットを使用

## 他のコマンドとの統合

- `/plan`を使用してテストすべき重要なジャーニーを特定
- `/tdd`をユニットテスト（より高速で詳細）に使用
- `/e2e`を統合テストとユーザージャーニーテストに使用
- `/code-review`を使用してテストの品質を確認

## 関連エージェント

このコマンドは以下にある`e2e-runner`エージェントを呼び出します:
`~/.claude/agents/e2e-runner.md`

## クイックコマンド

```bash
# すべてのE2Eテストを実行
npx playwright test

# 特定のテストファイルを実行
npx playwright test tests/e2e/markets/search.spec.ts

# ヘッドモードで実行（ブラウザを表示）
npx playwright test --headed

# テストをデバッグ
npx playwright test --debug

# テストコードを生成
npx playwright codegen http://localhost:3000

# レポートを表示
npx playwright show-report
```
