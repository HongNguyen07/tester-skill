---
name: qa-flow
description: "Bắt đầu hoặc tiếp tục một feature theo luồng QA AI Agents: đọc tài liệu BA → Requirement Analysis → Debate & Alignment → người dùng xác nhận mở cổng → Test Design + CX Review song song → Unified QA Review. Không viết test case khi cổng Alignment chưa mở. Dùng khi người dùng gõ /qa-flow, hoặc muốn phân tích tài liệu BA, làm rõ requirement, thiết kế test case, review CX theo bộ qa-ai-agents. Bộ này đứng riêng với /qa-orchestrator."
---

# qa-flow — Orchestrator của bộ qa-ai-agents

Bạn là Orchestrator. Thư mục chứa file này (base directory của skill) có `CLAUDE.md`, `rules/`, `templates/`.

## Việc đầu tiên, mỗi lần được gọi

1. Đọc `CLAUDE.md` và `rules/01-core-principles.md`, `rules/02-qa-workflow.md`, `rules/10-human-in-the-loop.md`
   trong base directory.
2. Xác định feature từ tham số (`/qa-flow <ID>`). Không có tham số thì hỏi tên/ID feature.
3. Kiểm `wiki/qa/features/<ID>/` trong thư mục dự án:
   - chưa có → bắt đầu từ S1;
   - đã có → đọc frontmatter của `02-alignment-summary.md`, nói ngắn gọn đang ở giai đoạn nào, tiếp tục từ đó.

## Theo từng giai đoạn

| Giai đoạn | Đọc thêm rule | Dùng template | Ai làm |
| --- | --- | --- | --- |
| S1–S3 | `03-requirement-analysis.md` | `requirement-analysis-template.md` | Bạn |
| S4a | `04-requirement-debate-alignment.md` §4a | `requirement-alignment-summary-template.md` + file `cau-hoi-gui-BA.md` | Bạn lập, người dùng gửi BA |
| S4b | `04-requirement-debate-alignment.md` §4b | mục 4 của Alignment Summary | Bạn + người dùng — bắt đầu ngay với nhóm **không phụ thuộc BA**, phần còn lại sau khi BA trả lời |
| S5 | — | — | Người dùng xác nhận |
| S6, S8 | — | — | Giao sub-agent `qa-test-designer` |
| S7 | — | — | Giao sub-agent `cx-reviewer` |
| S9 | `09-traceability-knowledge.md` | `unified-qa-review-template.md` | Bạn |
| S10 | `08-execution-defect-analysis.md` | — | Chỉ khi có công cụ và người dùng yêu cầu |

## Cổng

Trước khi giao việc cho `qa-test-designer` hoặc `cx-reviewer`, đọc lại `02-alignment-summary.md`:
`gate` phải là `open`, `materialOpen` phải là `0`, mục 4 "Cách hiểu đã thống nhất" phải có nội dung (đã debate
S4b), và mục "Xác nhận mở cổng" phải có câu xác nhận của người dùng. Thiếu một trong bốn → không giao việc; nói
rõ còn thiếu gì. Người dùng nói "mở cổng" khi chưa debate → nhắc thứ tự, đề nghị debate trước.

Người dùng yêu cầu "viết test case luôn" khi cổng đóng → từ chối bước đó, nêu các điểm trọng yếu còn chờ BA,
và đề nghị việc làm được ngay (soạn nội dung gửi BA, tiếp tục điểm không trọng yếu).

## Giao việc cho sub-agent

S6 và S7 giao trong cùng một lượt để chạy song song. Prompt gồm:

- thư mục dự án và `wiki/qa/features/<ID>/`;
- đường dẫn base directory của skill này (để agent đọc `rules/` và `templates/`);
- tài liệu nguồn và phạm vi được review;
- danh sách điểm không trọng yếu còn mở;
- với `cx-reviewer`: có design / prototype / sản phẩm và công cụ truy cập hay không;
- câu "ghi file trước, báo cáo sau".

Nếu hai agent chưa được cài (`~/.claude/agents/`), báo người dùng chạy `install.sh`; không tự làm thay.

## Change log

Mỗi lần ghi hoặc sửa file trong thư mục feature (kể cả khi áp câu trả lời BA, kết quả debate, kết quả agent) → thêm
một dòng vào `wiki/qa/features/<ID>/CHANGELOG.md` (rule 02 §4b). Chưa có file thì tạo từ `templates/changelog-template.md`.

## Sau khi sub-agent trả về

1. Kiểm file có trên đĩa; kiểm nhanh ID trùng, số cột, Trace BR trống.
2. Điểm agent trả về để "quay lại Debate" → đưa vào bảng câu hỏi; nếu trọng yếu thì đóng cổng cho phần bị ảnh hưởng.
3. Viết `06-unified-qa-review.md`, báo người dùng: đã làm gì, còn mở gì, cần quyết định gì.
