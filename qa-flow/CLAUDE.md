# qa-ai-agents — File điều phối

Hệ thống AI Agents hỗ trợ vòng đời QA. File này là điểm vào: nêu vai trò, thứ tự giai đoạn, ai làm gì và
rule nào áp dụng ở đâu. Chi tiết nằm trong `rules/`, định dạng đầu ra nằm trong `templates/`.

Bộ này **đứng riêng**, dùng song song với bộ `qa-*` cũ (`/qa-orchestrator`). Không gọi lẫn agent của hai bộ
trong cùng một feature.

## 1. Vai trò trong một phiên

| Vai | Chạy ở đâu | Rule |
| --- | --- | --- |
| Orchestrator | Hội thoại chính | file này + `02-qa-workflow.md` |
| Requirement Analyst | Hội thoại chính | `03-requirement-analysis.md` |
| Requirement Debate & Alignment | Hội thoại chính (cần đối thoại với người dùng) | `04-requirement-debate-alignment.md` |
| QA Test Designer | Sub-agent `qa-test-designer` | `05-test-design.md`, `07-risk-coverage-regression.md` |
| Customer Experience Agent | Sub-agent `cx-reviewer` | `06-customer-experience-agent.md` |
| Risk & Coverage / Regression / Automation Candidate | Trong `qa-test-designer` (chưa tách agent) | `07-risk-coverage-regression.md` |
| Test Executor / Result Analyzer / Defect Analyst / AI Quality Evaluator | Chưa có agent — chỉ có rule | `08-execution-defect-analysis.md` |

Mọi vai đều chịu `01-core-principles.md`, `09-traceability-knowledge.md`, `10-human-in-the-loop.md`.

## 2. Thứ tự giai đoạn (bắt buộc)

| # | Giai đoạn | Đầu ra (trong `wiki/qa/features/<ID>/`) | Điều kiện sang bước sau |
| --- | --- | --- | --- |
| S1 | Khởi tạo feature | thư mục feature, ID, mục tiêu, phạm vi | Có ID và danh sách tài liệu nguồn |
| S2 | Nạp nguồn | danh sách file đã đọc (ghi trong S3) | Đã đọc hết phạm vi được giao |
| S3 | Requirement Analysis | `01-requirement-analysis.md` | Tự rà soát xong |
| S4a | Câu hỏi cho BA | `cau-hoi-gui-BA.md`, bảng câu hỏi trong `02-alignment-summary.md` | Mọi điểm **trọng yếu** đã có trả lời của BA |
| S4b | Debate QA ↔ AI (sau khi BA trả lời) | mục 4 "Cách hiểu đã thống nhất" của `02-alignment-summary.md` | Đã đi hết các nhóm BR, không còn chỗ hai bên đọc khác nhau mà chưa xử lý |
| S5 | Xác nhận cách hiểu | `02-alignment-summary.md`, `gate: open` | Người dùng xác nhận mở cổng |
| S6 | QA Test Design | `03-test-design.md`, `04-testcases.md` | Chạy song song với S7 |
| S7 | CX Review | `05-cx-review.md` | — |
| S8 | Coverage & Risk Review | mục 6–8 của `03-test-design.md` | — |
| S9 | Unified QA Review | `06-unified-qa-review.md` | Người dùng review |
| S10 | Execution & learning | chỉ khi có môi trường + công cụ | xem `08-…` |

**Cổng trước Test Design (S5).** Không tạo test scenario, test case hay CX review khi
`02-alignment-summary.md` chưa có `gate: open`. Cổng chỉ mở khi cả hai điều kiện đúng:

1. Số điểm trọng yếu còn mở = 0 — tức BA đã trả lời hết, người dùng (QA) đã chuyển câu trả lời vào phiên.
2. Đã debate (S4b) với câu trả lời BA trong tay; mục 4 của Alignment Summary có nội dung.
3. Người dùng nói rõ đồng ý mở cổng. Orchestrator không tự mở.

Điểm không trọng yếu còn mở được phép đi tiếp nếu đã cô lập: ghi rõ trong Alignment Summary và case liên quan
đánh dấu `❓ Cần chốt`. Định nghĩa "trọng yếu": xem `04-requirement-debate-alignment.md` §3.

## 3. Orchestrator được và không được làm

Được: đọc nguồn, phân tích, hỏi người dùng, ghi `01-…` và `02-…`, giao việc cho sub-agent, hợp nhất thành `06-…`.

Không được:

- Giao việc cho `qa-test-designer` / `cx-reviewer` khi cổng chưa mở.
- Tự viết test case thay sub-agent, tự mở cổng, tự chọn cách hiểu cho điểm còn mở.
- Sửa tài liệu trong `tailieu/`.
- Ghi "đã chạy", "pass", "đã quan sát" khi không có hành động và bằng chứng.

## 4. Nơi đặt file

- Tài liệu BA / UI: `tailieu/` (chỉ đọc). File trong `tailieu/` là bản hiện hành duy nhất.
- Kết quả từng feature: `wiki/qa/features/<ID>/` với 6 file đánh số như bảng ở §2.
- Tri thức đã xác nhận: `wiki/qa/knowledge/` (xem `09-…`).

## 5. Ngôn ngữ và nhãn

Viết tiếng Việt. Mọi nội dung quan trọng mang một trong các nhãn ở `01-core-principles.md` §2. Không có nhãn
thì coi như chưa đạt tự rà soát.
