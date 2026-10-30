---
name: qa-api-test
description: "REST-assured (Java) & Karate (BDD) API contract testing rules the qa-automation-builder loads: given/when/then + JSON path assertions, status + schema, auth token + multi-tenant isolation, contract verification vs FEAT §3 (endpoint/method/DTO/ERR-NNN-xx), data setup/teardown, request-response evidence, TC-FEAT-NN traceability."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-api-test — API black-box contract test (BE side)

> **Black-box, xuyên HTTP.** Test API ở tầng contract (request → response), KHÔNG đọc/gọi internal service.
> Bổ sung — KHÔNG lặp lại — unit/integration/contract test của dev (`be-test-writer`). QA verify
> **hành vi đen thực tế** của endpoint so với **FEAT §3 Contract** (path · method · DTO · `ERR-<NNN>-xx`).
> Dùng bởi `qa-automation-builder` (sinh code) và `qa-test-executor` (chạy + ghi evidence).

## Core rules

1. **Contract là nguồn chân lý** — mọi assertion đối chiếu **FEAT §3** (endpoint path + HTTP method + request/response DTO field + status + `ERR-<NNN>-xx`). Response lệch contract = **contradiction (⑤ metric)**, KHÔNG "sửa test cho khớp code".
2. **Mỗi test map đúng 1 `TC-<FEAT>-NN`** — trace ngược 1 AC/US. No test without AC-source.
3. **Assert status + body + schema** — không chỉ `200 OK`. Verify field DTO, kiểu, giá trị bắt buộc; error case verify đúng mã `ERR-<NNN>-xx`, không chấp nhận "báo lỗi chung chung".
4. **Multi-tenant isolation là test bắt buộc** — tenant A **KHÔNG** đọc/ghi được data tenant B (mirror `be-multitenancy`). Thiếu test này với API có `tenantId` = gap nghiêm trọng.
5. **Authz negative test** — gọi thiếu token / sai permission / hết hạn → phải `401/403` đúng mã, không lọt.
6. **Isolated & repeatable** — mỗi test tự **setup data** (fixture) và **teardown/cleanup**; chạy lại nhiều lần cho kết quả như nhau (idempotent). KHÔNG phụ thuộc thứ tự test hay data sẵn có.
7. **Evidence bắt buộc** — log full **request + response** (đã mask secret) lưu làm **pass-evidence**; pass không evidence = KHÔNG hợp lệ (② metric).

---

## Pattern: contract → test mapping (FEAT §3)

```
FEAT §3 Contract                      →  Test assertion
────────────────────────────────────────────────────────────────
POST /api/v1/sms-campaigns            →  request spec: method + path
  request  CreateCampaignRequest      →  body có đủ field bắt buộc
    { name, templateId, segmentId }   →  gửi valid + gửi thiếu field → 400
  response 201 IdResponse { id }      →  statusCode(201) + body "id" != null
  errors:                             →
    ERR-SMS-01 template not found     →  case Error → status 404 + code "ERR-SMS-01"
    ERR-SMS-02 duplicate name         →  case Error → status 409 + code "ERR-SMS-02"
    ERR-SMS-03 quota exceeded         →  case Error → status 422 + code "ERR-SMS-03"
```

Mỗi dòng contract → tối thiểu 1 `TC-<FEAT>-NN` (Happy + Edge + Error). Endpoint/method/field/mã lỗi
mà response **không khớp** contract → ghi **contradiction**, route về BE (`status.be → review`), KHÔNG cho pass.

---

## Pattern: REST-assured — base config + auth token setup

```java
// src/test/java/qa/api/ApiTestBase.java
package qa.api;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.BeforeAll;

import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.notNullValue;

/** Base: baseURI, evidence logging, token cấp theo tenant + permission set. */
public abstract class ApiTestBase {

    protected static String baseUri = System.getProperty("qa.baseUri", "http://localhost:8080");
    protected static Path evidenceDir = Path.of(System.getProperty("qa.evidenceDir", "runs/api-evidence"));

    @BeforeAll
    static void setup() throws Exception {
        RestAssured.baseURI = baseUri;
        Files.createDirectories(evidenceDir);
    }

    /** Token OAuth2 cho 1 tenant + username; permission theo user (authz negative dùng user thiếu quyền). */
    protected static String tokenFor(String tenantId, String username, String password) {
        return given()
            .contentType(ContentType.URLENC)
            .formParam("grant_type", "password")
            .formParam("client_id", "tmkt-web")
            .formParam("username", username)
            .formParam("password", password)
            .header("X-Tenant-Id", tenantId)
        .when()
            .post("/oauth2/token")
        .then()
            .statusCode(200)
            .body("access_token", notNullValue())
            .extract().path("access_token");
    }

    /** Request spec chuẩn: bearer token + log request/response ra file evidence (mask ở filter riêng nếu cần). */
    protected RequestSpecification authed(String token, String tcId) throws Exception {
        PrintStream log = new PrintStream(Files.newOutputStream(evidenceDir.resolve(tcId + ".log")));
        return new RequestSpecBuilder()
            .setContentType(ContentType.JSON)
            .addHeader("Authorization", "Bearer " + token)
            .addFilter(new RequestLoggingFilter(log))   // full request → pass-evidence
            .addFilter(new ResponseLoggingFilter(log))  // full response → pass-evidence
            .build();
    }
}
```

## Pattern: REST-assured — given/when/then (Happy + status + schema + JSON path)

```java
// TC-SMS-01 (AC-1): tạo campaign hợp lệ → 201 + id. Contract: POST /api/v1/sms-campaigns → 201 IdResponse
@Test
void TC_SMS_01_createCampaign_happy() throws Exception {
    String token = tokenFor("tenant-A", "marketer-a", "pass");
    String body = """
        { "name": "Flash Sale 8/8", "templateId": "tpl-100", "segmentId": "seg-9" }
        """;

    given()
        .spec(authed(token, "TC-SMS-01"))
        .body(body)
    .when()
        .post("/api/v1/sms-campaigns")
    .then()
        .statusCode(201)                                              // status khớp contract
        .body(matchesJsonSchemaInClasspath("schema/id-response.json")) // schema DTO
        .body("id", notNullValue())                                   // JSON path field
        .body("id", instanceOf(String.class));
}
```

## Pattern: REST-assured — Error case (verify đúng ERR-<NNN>-xx)

```java
// TC-SMS-07 (AC-3): tạo với template không tồn tại → 404 + ERR-SMS-01 (contract §3)
@Test
void TC_SMS_07_createCampaign_templateNotFound() throws Exception {
    String token = tokenFor("tenant-A", "marketer-a", "pass");

    given()
        .spec(authed(token, "TC-SMS-07"))
        .body("""
            { "name": "X", "templateId": "tpl-DOES-NOT-EXIST", "segmentId": "seg-9" }
            """)
    .when()
        .post("/api/v1/sms-campaigns")
    .then()
        .statusCode(404)
        .body("code", equalTo("ERR-SMS-01"))   // đúng mã lỗi contract — KHÔNG chấp nhận mã khác
        .body("message", notNullValue());
}
```

## Pattern: REST-assured — MULTI-TENANT isolation (bắt buộc)

```java
// TC-SMS-12 (AC-tenant): tenant B KHÔNG đọc được campaign của tenant A → 404 (không phải 200, không phải 403 lộ tồn tại)
@Test
void TC_SMS_12_tenantIsolation_readCrossTenant_forbidden() throws Exception {
    // setup: tạo resource thuộc tenant A
    String tokenA = tokenFor("tenant-A", "marketer-a", "pass");
    String id = given().spec(authed(tokenA, "TC-SMS-12-setup"))
        .body("""{ "name":"A-only","templateId":"tpl-100","segmentId":"seg-9" }""")
        .when().post("/api/v1/sms-campaigns")
        .then().statusCode(201).extract().path("id");

    // act: tenant B cố đọc bằng id của tenant A
    String tokenB = tokenFor("tenant-B", "marketer-b", "pass");
    given()
        .spec(authed(tokenB, "TC-SMS-12"))
    .when()
        .get("/api/v1/sms-campaigns/{id}", id)
    .then()
        .statusCode(404);   // tenant scope: coi như không tồn tại — KHÔNG leak data cross-tenant

    // teardown: xóa resource tenant A
    given().spec(authed(tokenA, "TC-SMS-12-teardown"))
        .when().delete("/api/v1/sms-campaigns/{id}", id).then().statusCode(anyOf(is(200), is(204)));
}
```

## Pattern: REST-assured — authz negative + idempotency

```java
// TC-SMS-15: thiếu token → 401 ; sai permission → 403
@Test
void TC_SMS_15_authz_negative() throws Exception {
    given().contentType(JSON).body("""{ "name":"x" }""")
        .when().post("/api/v1/sms-campaigns")
        .then().statusCode(401);                        // no token

    String viewerToken = tokenFor("tenant-A", "viewer-a", "pass"); // user thiếu CREATE permission
    given().spec(authed(viewerToken, "TC-SMS-15-403"))
        .body("""{ "name":"x","templateId":"tpl-100","segmentId":"seg-9" }""")
        .when().post("/api/v1/sms-campaigns")
        .then().statusCode(403);                        // đúng permission code, không lọt
}

// TC-SMS-18: idempotency — gửi cùng Idempotency-Key 2 lần → 1 resource, không tạo trùng
@Test
void TC_SMS_18_idempotentCreate() throws Exception {
    String token = tokenFor("tenant-A", "marketer-a", "pass");
    String key = "idem-" + java.util.UUID.randomUUID();
    var body = """{ "name":"Idem test","templateId":"tpl-100","segmentId":"seg-9" }""";

    String id1 = given().spec(authed(token, "TC-SMS-18-a")).header("Idempotency-Key", key)
        .body(body).when().post("/api/v1/sms-campaigns").then().statusCode(201).extract().path("id");
    String id2 = given().spec(authed(token, "TC-SMS-18-b")).header("Idempotency-Key", key)
        .body(body).when().post("/api/v1/sms-campaigns").then().statusCode(anyOf(is(200), is(201))).extract().path("id");

    assertThat(id2, equalTo(id1));  // cùng resource — không tạo bản trùng
}
```

## Data setup / teardown / cleanup

```java
// Mỗi test class tự dựng & dọn data — không dựa vào seed sẵn, không để rác giữa các run.
@BeforeEach void seed()    { /* tạo template/segment fixture qua API hoặc SQL fixture endpoint */ }
@AfterEach  void cleanup() { /* DELETE mọi resource test tạo ra; verify 204/200 */ }
```

- **Isolation:** dùng tenant/user riêng cho test (`tenant-A`, `tenant-B`), tránh đụng data thật.
- **Repeatable:** name có suffix random/UUID để re-run không dính `ERR-*-duplicate`.
- **Teardown chắc chắn:** `@AfterEach`/`@AfterAll` chạy cả khi test fail (finally-semantics).

---

## Pattern: Karate (BDD) — alternative

`sms-campaign.feature` — contract test dạng khai báo, scenario outline cho data-driven.

```gherkin
Feature: SMS Campaign API contract (FEAT-042 §3)

  Background:
    * url baseUrl
    # token theo tenant + permission (helper trong karate-config.js / auth.feature)
    * def signIn = call read('classpath:auth.feature') { tenant: 'tenant-A', user: 'marketer-a' }
    * def tokenA = signIn.accessToken
    * configure headers = { Authorization: '#("Bearer " + tokenA)' }

  # TC-SMS-01 (AC-1): Happy — tạo campaign hợp lệ
  Scenario: create campaign returns 201 + id
    Given path 'api/v1/sms-campaigns'
    And request { name: 'Flash Sale 8/8', templateId: 'tpl-100', segmentId: 'seg-9' }
    When method post
    Then status 201
    And match response == { id: '#string' }          # schema/contract DTO

  # TC-SMS-07..09 (AC-3): Error — data-driven, verify đúng ERR-<NNN>-xx theo contract §3
  Scenario Outline: create campaign error <case> -> <status> <code>
    Given path 'api/v1/sms-campaigns'
    And request <body>
    When method post
    Then status <status>
    And match response.code == '<code>'

    Examples:
      | case            | body                                                              | status | code        |
      | template-404    | { name:'X', templateId:'nope', segmentId:'seg-9' }                | 404    | ERR-SMS-01  |
      | duplicate-name  | { name:'DUP', templateId:'tpl-100', segmentId:'seg-9' }           | 409    | ERR-SMS-02  |
      | quota-exceeded  | { name:'Q', templateId:'tpl-100', segmentId:'seg-BIG' }           | 422    | ERR-SMS-03  |

  # TC-SMS-12 (AC-tenant): multi-tenant isolation — tenant B không đọc được của tenant A
  Scenario: cross-tenant read is not found
    Given path 'api/v1/sms-campaigns'
    And request { name: 'A-only', templateId: 'tpl-100', segmentId: 'seg-9' }
    When method post
    Then status 201
    * def id = response.id
    # đổi sang token tenant B
    * def signInB = call read('classpath:auth.feature') { tenant: 'tenant-B', user: 'marketer-b' }
    * configure headers = { Authorization: '#("Bearer " + signInB.accessToken)' }
    Given path 'api/v1/sms-campaigns', id
    When method get
    Then status 404                                   # không leak cross-tenant
```

> Karate log request/response mặc định vào `target/karate-reports/` (HTML) → dùng làm **pass-evidence**.

---

## Traceability & evidence

| Artifact | Convention |
|---|---|
| Test id | Tên method / scenario mang đúng `TC-<FEAT>-NN` (vd `TC_SMS_01`, `TC-SMS-01`) |
| Trace | Comment/tag ghi rõ AC/US nguồn (`AC-1`) — mỗi TC map đúng 1 AC-source |
| Evidence | REST-assured: `runs/api-evidence/<TC>.log` (request+response). Karate: `target/karate-reports/*.html` |
| Report về executor | `qa-test-executor` map kết quả từng TC → `Passed/Failed/Blocked/Not-run` + path evidence |

Secret (token, password, PII) phải **mask** trong log evidence trước khi lưu.

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| Chỉ assert `statusCode(200)`, bỏ body/schema | Assert status **+** DTO field **+** schema; error verify đúng `ERR-<NNN>-xx` |
| "Sửa test cho khớp code" khi response lệch contract | Ghi **contradiction (⑤)**, route BE `→ review`, giữ assertion theo FEAT §3 |
| Bỏ qua multi-tenant test cho API có `tenantId` | Luôn có TC tenant A ⊄ tenant B (read/write/list) |
| Chấp nhận `403`/`500` cho case Error thay vì mã contract | Verify **đúng** `ERR-<NNN>-xx` + đúng status contract |
| Test phụ thuộc data seed sẵn / thứ tự chạy | Tự setup fixture + teardown; independent, idempotent |
| Đánh Passed mà không lưu request/response log | Pass phải kèm evidence path (② metric) — thiếu = `unverified` |
| Hardcode token/secret trong test | Cấp token runtime qua `tokenFor(...)`; mask trong log |
| Method name vô nghĩa (`test1`, `testCreate`) | Mang `TC-<FEAT>-NN` + trace AC để executor map được |
| Test lại unit/integration của dev (mock service, gọi repository) | Chỉ black-box qua HTTP contract; white-box là `be-test-writer` |

---

## Integration with other skills / agents

- `qa-automation-builder` — sinh REST-assured/Karate code theo skill này.
- `qa-test-executor` — chạy + ghi evidence + map `TC-<FEAT>-NN`.
- `qa-test-case-writer` — nguồn TC (Happy/Edge/Error) mà API test hiện thực hóa.
- `qa-test-data` — fixture / tenant isolation data setup.
- `code-be-multitenancy` — nguồn rule tenant isolation cần verify.
- `code-be-security` / `code-be-exception` — permission code + `ERR-<NNN>-xx` GlobalExceptionHandler để đối chiếu.

---

## Checklist

- [ ] Mỗi test map đúng 1 `TC-<FEAT>-NN` + trace 1 AC/US (No test without AC-source)
- [ ] Assert **status + body DTO field + schema** (không chỉ 200)
- [ ] Error case verify **đúng** `ERR-<NNN>-xx` + đúng status theo FEAT §3
- [ ] Endpoint path + method + request/response DTO khớp contract; lệch → ghi **contradiction (⑤)**
- [ ] Multi-tenant isolation test (tenant A ⊄ tenant B: read/write/list) cho mọi API có `tenantId`
- [ ] Authz negative: no-token → 401, thiếu permission → 403 (đúng permission code)
- [ ] Idempotency test cho create/mutation có Idempotency-Key
- [ ] Data setup (fixture) + teardown/cleanup; test independent + idempotent (re-run OK)
- [ ] Request/response log lưu làm **pass-evidence** (② metric); secret đã mask
- [ ] KHÔNG lặp unit/integration/contract của dev (chỉ black-box qua HTTP)

---

## Related memory

- `feedback_assert_full_contract_not_just_status.md`
- `feedback_multi_tenant_isolation_mandatory.md`
- `feedback_error_code_must_match_contract.md`
- `feedback_pass_requires_request_response_evidence.md`
