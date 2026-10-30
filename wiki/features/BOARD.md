# BOARD — Feature status (GENERATED — KHÔNG hand-edit)

> View sinh ra từ mọi `wiki/features/FEAT-*.md` (glob → roll-up). Regenerate bằng
> bước `board-build` (1 owner) hoặc on-read. Sửa tay ở đây sẽ bị ghi đè.
> Nguồn chuẩn là từng file FEAT.

_Chưa có feature nào. Bảng dưới tự điền khi có FEAT._

| FEAT | Tên | Lane | BA | BE (owner) | FE (owner) | Blocked |
| --- | --- | --- | --- | --- | --- | --- |
| FEAT-001 | ... | normal | ✅ | 🚧 b2 | ⛔ waiting be.contract | fe←be |

## Bộ lọc gợi ý (khi board-build sinh ra)

- **Open cho BE**: `status.be=ready & owners.be=null`
- **Open cho FE**: `status.fe=ready & owners.fe=null` (đã qua gate dep)
- **Blocked**: `status.*=blocked` + lý do
- **Stale claim**: `claim.*.at` > 3 ngày & status=in-progress
