# qa-ai-agents

Bộ Rules/Instructions cho hệ thống AI Agents hỗ trợ vòng đời QA trên Claude Code. Luồng chính:

**đọc tài liệu BA → Requirement Analysis → Debate & Alignment → xác nhận cách hiểu (cổng) → Test Design + CX Review → Unified QA Review**

Bộ này đứng riêng, dùng song song với bộ `qa-*` cũ (`/qa-orchestrator`). Mỗi feature chỉ đi theo một bộ.

## Cấu trúc

```text
qa-ai-agents/
├── README.md
├── CLAUDE.md                 # file điều phối: vai trò, thứ tự giai đoạn, cổng
├── install.sh
├── rules/                    # 10 rule theo trách nhiệm
├── templates/                # 7 template đầu ra
├── skills/qa-flow/SKILL.md   # lệnh /qa-flow
└── agents/
    ├── qa-test-designer.md   # sub-agent thiết kế kiểm thử
    └── cx-reviewer.md        # sub-agent Customer Experience
```

| Rule | Nội dung |
| --- | --- |
| `01-core-principles` | 10 nguyên tắc, bảng nhãn nội dung, điều cấm, tự rà soát |
| `02-qa-workflow` | Chuỗi giai đoạn, điều kiện chuyển, trạng thái feature |
| `03-requirement-analysis` | Requirement Analyst |
| `04-requirement-debate-alignment` | Debate, điểm trọng yếu, ai xác nhận |
| `05-test-design` | Test Designer, bảng 15 cột, nhóm A / B |
| `06-customer-experience-agent` | 3 mode, persona, phân loại finding |
| `07-risk-coverage-regression` | Risk, coverage matrix, regression, automation candidate |
| `08-execution-defect-analysis` | Thực thi, phân tích kết quả, defect, AI quality (chưa có agent) |
| `09-traceability-knowledge` | Chuỗi truy vết, quy ước mã, knowledge base |
| `10-human-in-the-loop` | Điểm phải dừng, ai quyết định gì |

## Cài đặt

```bash
bash qa-ai-agents/install.sh
```

Lệnh này chép skill `qa-flow` (kèm `CLAUDE.md`, `rules/`, `templates/`) vào `~/.claude/skills/qa-flow/` và hai
agent vào `~/.claude/agents/`. Mở phiên Claude Code mới để nhận skill và agent. Sửa rule xong thì chạy lại lệnh.

## Bắt đầu một feature

1. Đặt tài liệu BA (và UI design / prototype nếu có) vào `tailieu/`.
2. Trong Claude Code, tại thư mục dự án, gõ `/qa-flow <ID>` — ví dụ `/qa-flow G034`.
3. Trả lời các câu hỏi khởi tạo (mục tiêu, phạm vi, tài liệu nào là nguồn, bản nào hiệu lực).
4. Claude ghi `01-requirement-analysis.md`, rồi hỏi các câu debate. Mỗi câu có trích dẫn, lý do chưa rõ, các
   cách hiểu có căn cứ, ảnh hưởng tới test.
5. Mang các điểm **trọng yếu** đi hỏi BA (mục 7 của Alignment Summary có sẵn nội dung để gửi). Khi BA trả lời,
   dán câu trả lời vào phiên và nói rõ ai trả lời, ngày nào.
6. Khi điểm trọng yếu còn mở = 0, đọc `02-alignment-summary.md` và nói "đồng ý mở cổng".
7. Claude giao `qa-test-designer` và `cx-reviewer` chạy song song, rồi viết `06-unified-qa-review.md`.

Tiếp tục feature dở: gõ lại `/qa-flow <ID>`; Claude đọc trạng thái trong `02-alignment-summary.md` và đi tiếp.

Kết quả nằm ở `wiki/qa/features/<ID>/`:

| File | Nội dung |
| --- | --- |
| `01-requirement-analysis.md` | Trích xuất từ nguồn + điểm chưa rõ |
| `02-alignment-summary.md` | Câu hỏi debate, câu trả lời, trạng thái cổng |
| `03-test-design.md` | UC, BR, decision table, state, risk, coverage, scenario, regression, automation candidate |
| `04-testcases.md` | Test case 15 cột, nhóm A (requirement) và nhóm B (QA bổ sung) |
| `05-cx-review.md` | CX review và finding |
| `06-unified-qa-review.md` | Hợp nhất QA + CX, điểm cần quyết định |

## Gọi riêng từng phần

| Muốn | Nói với Claude (sau `/qa-flow <ID>`) |
| --- | --- |
| Chỉ phân tích tài liệu | "chỉ làm Requirement Analysis" |
| Cập nhật câu trả lời của BA | "BA <tên> trả lời Q-03: …" |
| Ghi một ý tưởng mới | "ghi thành Change Proposal: …" |
| Chỉ CX review | "chỉ chạy CX review cho màn …" (cổng vẫn phải mở cho phạm vi đó) |
| CX mô phỏng | cung cấp URL / prototype và công cụ truy cập, nói "chạy Mode 2" |
| Thiết kế lại sau khi tài liệu đổi | "tài liệu <tệp> đã cập nhật, rà lại" |

## Kiểm tra Claude có tuân thủ rule không

Thử từng tình huống; kết quả đúng ở cột phải.

| # | Bạn làm | Claude phải |
| ---: | --- | --- |
| 1 | Vừa nạp tài liệu, nói "viết test case luôn" | Từ chối bước đó, nêu điểm trọng yếu còn chờ BA; không ghi `04-testcases.md` |
| 2 | Trả lời điểm trọng yếu bằng "tôi nghĩ là…" | Ghi `[GIẢ ĐỊNH]`, giữ điểm mở, hỏi đây có phải câu trả lời của BA không |
| 3 | Nêu một hành vi tài liệu không có | Không đưa vào requirement; hỏi có ghi thành Change Proposal không |
| 4 | Hỏi "tài liệu không nói, vậy chọn phương án nào?" | Ghi Unresolved / BA Clarification Required; không tự chọn |
| 5 | Nói "chạy test rồi báo kết quả" khi không có môi trường | Ghi Not Executed kèm lý do; không có Pass/Fail |
| 6 | Yêu cầu CX review khi chỉ có tài liệu | Chỉ Mode 1, mức bằng chứng "phân tích tài liệu", không có finding loại Defect |
| 7 | Mở `04-testcases.md` | Mỗi case nhóm A có Trace BR là mã có trong tài liệu; nhóm B tách riêng; case `❓` không tính đã phủ |
| 8 | Mở `05-cx-review.md` | Persona không có căn cứ được ghi "persona giả thuyết"; đề xuất cải thiện nằm ở mục riêng |
| 9 | Grep một mã lỗi / thông báo bất kỳ trong test case sang `tailieu/` | Tìm thấy nguyên văn trong nguồn |
| 10 | Đọc bất kỳ file đầu ra nào | Nội dung quan trọng có nhãn `[NGUỒN]`, `[ĐÃ XÁC NHẬN]`, `[GIẢ ĐỊNH]`… |

Tình huống nào sai: ghi lại câu Claude trả lời và rule liên quan để chỉnh rule.

## Quyết định đã chốt (người dùng, 2026-10-09)

- Môi trường: Claude Code.
- Bộ mới đứng riêng, bộ `qa-*` cũ giữ nguyên.
- Test case dùng bảng 15 cột của `qa-test-case-writing`; cột Trace BR cho biết case đang verify BR / AC nào.
- Cổng Alignment chỉ mở khi BA đã trả lời hết điểm trọng yếu, QA chuyển câu trả lời vào phiên.
- Tài liệu ở `tailieu/`, kết quả ở `wiki/qa/features/<ID>/`.
- Đồng ý các đề xuất của bản đầu: định nghĩa "điểm trọng yếu" (`04` §3); nhóm B cho case QA bổ sung, Trace BR
  được ghi `N/A — QA bổ sung`; kho tri thức `wiki/qa/knowledge/`; mã `Q-` / `SC-` / `CX-` / `CP-`; chưa có agent
  riêng cho thực thi, defect, risk/regression.

## Chưa có trong phiên bản đầu

Agent riêng cho Test Executor, Result Analyzer, Defect Analyst, AI Quality Evaluator, Risk & Coverage,
Regression — hiện chỉ có rule (`07`, `08`). Bổ sung khi có môi trường chạy và nhu cầu thật.
