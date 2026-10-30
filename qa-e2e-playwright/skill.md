---
name: qa-e2e-playwright
description: "Playwright E2E + a11y patterns the qa-automation-builder loads — Page Object Model, getByRole/getByTestId selectors, web-first auto-wait assertions, axe-core a11y scan, trace/screenshot/video evidence, TC-FEAT-NN traceability, storageState auth reuse, flaky mitigation without blanket retries."
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# qa-e2e-playwright — Playwright E2E + a11y Skill

> Rules cụ thể cho **automation E2E web** (black-box, xuyên discipline). `qa-automation-builder`
> đọc skill này khi sinh code Playwright; `qa-test-executor` đọc để hiểu evidence artifact nào là
> **pass-evidence** hợp lệ. Mỗi test trace ngược 1 `TC-<FEAT>-NN` (do `qa-test-case-writer` sinh).

## Core rules

1. **Selector ưu tiên `getByRole` / `getByTestId`** — user-facing + accessibility-first. NGHIÊM CẤM brittle CSS class / xpath / nth-child.
2. **Web-first assertions, KHÔNG `waitForTimeout` tùy tiện** — `expect(locator).toBeVisible()` tự retry. Arbitrary sleep = flaky.
3. **Page Object Model** — locator + action đóng gói trong POM, test file chỉ mô tả kịch bản. Không rải raw selector khắp test.
4. **Evidence bắt buộc**: `trace: 'on-first-retry'`, `screenshot: 'only-on-failure'`, `video: 'retain-on-failure'`. Đây là **pass-evidence artifact** QA yêu cầu.
5. **a11y scan mọi màn hình chính** qua `@axe-core/playwright` — assert **no critical/serious violations**.
6. **Fresh state + isolation** mỗi test — không phụ thuộc thứ tự chạy, không dùng lại data giữa test. `fullyParallel: true`.
7. **Auth 1 lần** qua `storageState` (global setup) — không login lại trong từng test.
8. **Trace tag `@TC-<FEAT>-NN`** trên mỗi test → traceability về AC/US.
9. **Flaky fix ĐÚNG**: sửa root cause (wait đúng, isolate, seed fresh). `retries` chỉ để phát hiện flaky (trace on-first-retry), KHÔNG dùng retry cao để giấu flakiness.

---

## Project structure

```
e2e/
  playwright.config.ts
  fixtures/
    auth.setup.ts            # login 1 lần → lưu storageState
    test-data.ts             # seed / teardown API helper
  pages/                     # Page Object Model
    login.page.ts
    campaign.page.ts
  tests/
    campaign-create.spec.ts  # tag @TC-CAMP-01 ...
  utils/
    a11y.ts                  # axe scan helper
  .auth/                     # storageState (gitignore)
  playwright-report/         # HTML report (evidence)
  test-results/              # trace.zip / video / screenshot (evidence)
```

## Pattern: playwright.config.ts baseline

```typescript
// e2e/playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,               // mỗi test isolate, chạy song song
  forbidOnly: !!process.env.CI,      // fail CI nếu lỡ .only
  retries: process.env.CI ? 1 : 0,   // 1 retry CHỈ để lộ flaky qua trace, KHÔNG giấu
  workers: process.env.CI ? 2 : undefined,
  timeout: 30_000,
  expect: { timeout: 5_000 },        // web-first assertion auto-retry trong 5s

  reporter: [
    ['html', { open: 'never' }],     // playwright-report/ = evidence
    ['list'],
    ['junit', { outputFile: 'test-results/junit.xml' }], // cho qa-test-executor parse
  ],

  use: {
    baseURL: process.env.BASE_URL ?? 'http://localhost:3000',
    trace: 'on-first-retry',         // EVIDENCE: trace.zip khi retry
    screenshot: 'only-on-failure',   // EVIDENCE: ảnh khi fail
    video: 'retain-on-failure',      // EVIDENCE: video khi fail
    actionTimeout: 10_000,
  },

  projects: [
    { name: 'setup', testMatch: /auth\.setup\.ts/ },
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'], storageState: 'e2e/.auth/user.json' },
      dependencies: ['setup'],       // login trước, tái dùng storageState
    },
  ],
});
```

## Pattern: Auth 1 lần qua storageState

```typescript
// e2e/fixtures/auth.setup.ts
import { test as setup, expect } from '@playwright/test';

const authFile = 'e2e/.auth/user.json';

setup('authenticate', async ({ page }) => {
  await page.goto('/login');
  await page.getByLabel('Email').fill(process.env.QA_USER!);
  await page.getByLabel('Mật khẩu').fill(process.env.QA_PASS!);
  await page.getByRole('button', { name: 'Đăng nhập' }).click();

  // Đợi tín hiệu login xong (web-first), KHÔNG waitForTimeout
  await expect(page.getByRole('heading', { name: 'Bảng điều khiển' })).toBeVisible();

  await page.context().storageState({ path: authFile });
});
```

## Pattern: Page Object Model

```typescript
// e2e/pages/campaign.page.ts
import { type Page, type Locator, expect } from '@playwright/test';

export class CampaignPage {
  readonly page: Page;
  readonly nameInput: Locator;
  readonly channelSelect: Locator;
  readonly submitBtn: Locator;
  readonly successToast: Locator;

  constructor(page: Page) {
    this.page = page;
    // getByRole / getByLabel / getByTestId — KHÔNG CSS class
    this.nameInput = page.getByLabel('Tên chiến dịch');
    this.channelSelect = page.getByLabel('Kênh gửi');
    this.submitBtn = page.getByRole('button', { name: 'Tạo chiến dịch' });
    this.successToast = page.getByRole('status').filter({ hasText: 'Tạo thành công' });
  }

  async goto() {
    await this.page.goto('/campaigns/new');
    await expect(this.nameInput).toBeVisible();
  }

  async create(name: string, channel: 'SMS' | 'ZNS') {
    await this.nameInput.fill(name);
    await this.channelSelect.selectOption(channel);
    await this.submitBtn.click();
  }

  async expectCreated() {
    await expect(this.successToast).toBeVisible(); // auto-wait, không sleep
  }
}
```

## Pattern: Test file + traceability tag

```typescript
// e2e/tests/campaign-create.spec.ts
import { test, expect } from '@playwright/test';
import { CampaignPage } from '../pages/campaign.page';
import { seedTenant, cleanupTenant } from '../fixtures/test-data';
import { assertNoA11yViolations } from '../utils/a11y';

// describe = 1 FEAT; mỗi test tag @TC-<FEAT>-NN → trace về AC/US
test.describe('FEAT-042 Campaign creation', { tag: '@FEAT-042' }, () => {
  let tenantId: string;

  test.beforeEach(async () => {
    tenantId = await seedTenant();          // fresh state mỗi test
  });
  test.afterEach(async () => {
    await cleanupTenant(tenantId);          // teardown — isolation
  });

  test('tạo chiến dịch SMS hợp lệ @TC-CAMP-01', async ({ page }, testInfo) => {
    testInfo.annotations.push({ type: 'ac', description: 'AC-1: user tạo campaign SMS' });

    const campaign = new CampaignPage(page);
    await campaign.goto();
    await campaign.create('Khuyến mãi Tết', 'SMS');
    await campaign.expectCreated();

    await assertNoA11yViolations(page, 'campaign-new'); // a11y trên màn hình
  });

  test('tên rỗng hiển thị lỗi validation @TC-CAMP-02', async ({ page }) => {
    const campaign = new CampaignPage(page);
    await campaign.goto();
    await campaign.submitBtn.click();
    await expect(page.getByRole('alert')).toHaveText(/Tên chiến dịch bắt buộc/);
  });
});
```

## Pattern: a11y scan với axe-core

```typescript
// e2e/utils/a11y.ts
import { type Page, expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

export async function assertNoA11yViolations(page: Page, label: string) {
  const results = await new AxeBuilder({ page })
    .withTags(['wcag2a', 'wcag2aa'])          // scope: WCAG A + AA
    .analyze();

  // Attach full report làm EVIDENCE (kể cả khi pass)
  await test.info().attach(`a11y-${label}.json`, {
    body: JSON.stringify(results.violations, null, 2),
    contentType: 'application/json',
  });

  const blocking = results.violations.filter(
    (v) => v.impact === 'critical' || v.impact === 'serious',
  );
  expect(blocking, `A11y critical/serious ở ${label}: ${blocking.map((v) => v.id).join(', ')}`)
    .toEqual([]);
}
```

## Pattern: Test data setup/teardown qua API (không qua UT)

```typescript
// e2e/fixtures/test-data.ts
import { request } from '@playwright/test';

const API = process.env.API_URL ?? 'http://localhost:8080';

// Seed qua API nhanh + ổn định hơn dựng state bằng click UI
export async function seedTenant(): Promise<string> {
  const ctx = await request.newContext({ baseURL: API });
  const res = await ctx.post('/internal/test/tenant', {
    data: { name: `qa-${Date.now()}` },
    headers: { Authorization: `Bearer ${process.env.QA_ADMIN_TOKEN}` },
  });
  const { tenantId } = await res.json();
  await ctx.dispose();
  return tenantId;
}

export async function cleanupTenant(tenantId: string): Promise<void> {
  const ctx = await request.newContext({ baseURL: API });
  await ctx.delete(`/internal/test/tenant/${tenantId}`, {
    headers: { Authorization: `Bearer ${process.env.QA_ADMIN_TOKEN}` },
  });
  await ctx.dispose();
}
```

---

## Selector strategy

| Ưu tiên | Cách dùng | Lý do |
|---|---|---|
| 1 | `getByRole('button', { name: '…' })` | Accessibility tree — bền + a11y-first |
| 2 | `getByLabel` / `getByPlaceholder` / `getByText` | User-facing, đọc như user thao tác |
| 3 | `getByTestId('…')` (`data-testid`) | Khi không có role/label ổn định |
| ✗ | `page.locator('.btn-primary')` / CSS class | Vỡ khi refactor style |
| ✗ | `page.locator('xpath=//div[3]/span')` | Cực brittle, phụ thuộc DOM structure |
| ✗ | `.nth(2)` theo vị trí | Phụ thuộc thứ tự render |

> FE dùng `data-testid` cần điều phối với `code-fe-*` (thêm vào common component). Prefer role/label trước.

---

## Evidence — pass-evidence artifact QA yêu cầu

| Artifact | Config | Khi nào | Vai trò |
|---|---|---|---|
| `trace.zip` | `trace: 'on-first-retry'` | Khi retry/fail | Timeline + DOM snapshot + network — mở bằng `npx playwright show-trace` |
| Screenshot | `screenshot: 'only-on-failure'` | Khi fail | Ảnh trạng thái lỗi |
| Video | `video: 'retain-on-failure'` | Khi fail | Replay kịch bản fail |
| HTML report | `reporter: ['html']` | Mọi run | `playwright-report/` — tổng hợp |
| a11y JSON | `test.info().attach` | Mọi run | axe violations, kể cả pass |
| JUnit XML | `reporter: ['junit']` | Mọi run | `qa-test-executor` parse map về `TC-<FEAT>-NN` |

**Quy tắc:** `qa-test-executor` chỉ đánh **Passed** khi có **path artifact cụ thể**. Pass không evidence = `unverified`, KHÔNG tính Passed.

---

## Flaky mitigation — làm ĐÚNG

| Nguồn flaky | Fix ĐÚNG | NGHIÊM CẤM |
|---|---|---|
| Race điều kiện load | `expect(locator).toBeVisible()` web-first auto-wait | `waitForTimeout(3000)` |
| Data còn sót từ test trước | Fresh seed `beforeEach` + teardown `afterEach` | Chạy theo thứ tự cố định |
| Animation/toast biến mất | Assert vào role=status/alert, `toBeVisible`/`toBeHidden` | sleep rồi click |
| Network chưa xong | `page.waitForResponse` / `expect` kết quả UI | fixed sleep |
| Test phụ thuộc nhau | `fullyParallel` + isolate state | share biến global giữa test |
| Ẩn flaky bằng retry cao | `retries: 1` chỉ để **lộ** flaky qua trace → fix root cause | `retries: 5` giấu lỗi |

> Retry cao che giấu flakiness = vi phạm. Trace on-first-retry để **chẩn đoán**, không phải để "pass bừa".

---

## Traceability

- **`test.describe(..., { tag: '@FEAT-NNN' })`** — nhóm theo feature spine.
- **`@TC-<FEAT>-NN` trong title mỗi test** — trace 1-1 về test case của `qa-test-case-writer`.
- **`testInfo.annotations`** ghi `ac` / `us` → map lên AC/US trong QA_COVERAGE_MATRIX.
- Chạy lọc theo tag: `npx playwright test --grep "@TC-CAMP-01"`.
- No test without AC-source: mọi spec phải trace 1 AC/US (mirror BA No-source rule).

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| `page.waitForTimeout(2000)` | Web-first `expect(locator).toBeVisible()` |
| `page.locator('.MuiButton-root')` (CSS class) | `getByRole('button', { name })` |
| Locator rải khắp test file | Đóng gói trong Page Object |
| Login lại trong từng test | `storageState` global setup |
| Test phụ thuộc test trước | Fresh seed + teardown mỗi test |
| `retries: 5` để pass CI | Fix root cause; `retries: 1` chỉ lộ flaky |
| Đánh Passed không có artifact | Chỉ Passed khi có trace/screenshot/log path |
| Bỏ qua a11y scan | axe `withTags(wcag2a, wcag2aa)`, assert no critical/serious |
| `if (await el.isVisible())` rồi mới assert | Assert trực tiếp — web-first tự retry |
| Seed data bằng click UI dài dòng | Seed qua API (`request.newContext`) |
| Hardcode credential/token trong code | `process.env.*`, `.auth/` gitignore |
| Test không tag TC | Tag `@TC-<FEAT>-NN` trace về AC |

---

## Integration with other skills / agents

- `qa-automation-builder` (agent) — sinh code Playwright dựa trên skill này.
- `qa-test-executor` (agent) — chạy `npx playwright test`, map JUnit → `TC-<FEAT>-NN`, thu evidence.
- `qa-test-case-writer` (agent) — nguồn `TC-<FEAT>-NN` + `evidence-required` cho mỗi test.
- `qa-test-data` (skill) — fixtures + tenant isolation (khớp `be-multitenancy`).
- `qa-api-test` (skill) — REST-assured/Karate cho tầng API; Playwright lo E2E web.
- `code-fe-accessibility` (skill) — nguồn tiêu chuẩn a11y mà axe scan kiểm chứng.
- `qa-reviewer` (agent) — scoring: faithfulness (trace AC), evidence-backed pass, flaky = bất định.

---

## Checklist

- [ ] `playwright.config.ts`: `trace: on-first-retry`, `screenshot: only-on-failure`, `video: retain-on-failure`
- [ ] `fullyParallel: true` + `retries` thấp (0 local, 1 CI để lộ flaky)
- [ ] `storageState` global setup — không login lặp trong test
- [ ] Selector chỉ `getByRole` / `getByLabel` / `getByTestId` — KHÔNG CSS class / xpath / nth
- [ ] Locator đóng gói trong Page Object, test file chỉ mô tả kịch bản
- [ ] Web-first assertion (`toBeVisible`/`toHaveText`…) — KHÔNG `waitForTimeout`
- [ ] Mỗi test tag `@TC-<FEAT>-NN` + annotation AC/US
- [ ] Fresh seed `beforeEach` + teardown `afterEach` (tenant isolation)
- [ ] Seed data qua API, không dựng state bằng UI
- [ ] axe scan (`wcag2a`/`wcag2aa`) mọi màn hình chính, assert no critical/serious + attach report
- [ ] Reporter: html + junit (cho executor parse) + list
- [ ] Credential/token qua `process.env`, `.auth/` trong `.gitignore`
- [ ] Flaky fix root cause — KHÔNG blanket retry giấu lỗi
- [ ] Mọi Passed có path evidence (trace/screenshot/video/axe-report)

---

## Related memory

- `feedback_no_arbitrary_waitfor_timeout.md`
- `feedback_prefer_getbyrole_over_css.md`
- `feedback_evidence_backed_pass_only.md`
- `feedback_flaky_fix_root_cause_not_retry.md`
