# [NR/CR] [Zalo Chat] Hiển thị người gửi và tên file trên danh sách hội thoại

| **Request** | | | |
|---|---|---|---|
| Component | [Zalo Chat]<br>Hiển thị người gửi và tên file trên danh sách hội thoại | ID | — |
| Requested by | AVZ - Khách hàng | Date | 19/10/2026 |
| Priority | Medium | | |
| Status | Approved | | |
| Written by | BA - Nguyễn Thị Phương Thảo | | |

## 1. Business Objective

Tại sidebar danh sách hội thoại, dòng tin nhắn bên dưới tên hội thoại hiện chưa thể hiện người gửi. Nhân sự phải mở hội thoại để xác định người gửi, gây khó khăn khi theo dõi hội thoại nhóm và phối hợp xử lý khách hàng. Đối với tin nhắn file, danh sách chỉ hiển thị nhãn `[Tệp]`, chưa thể hiện tên file nên khó nhận diện tài liệu đã trao đổi.

Bổ sung thông tin người gửi và hiển thị tên file trên danh sách hội thoại, giúp nhân sự nhận diện nhanh người gửi và nội dung trao đổi mà không cần mở từng hội thoại.

Trong tài liệu này, **dòng tin nhắn** là dòng hiển thị tin nhắn gần nhất của từng hội thoại, nằm bên dưới tên hội thoại trên danh sách. Tin đã đọc và tin chưa đọc đều được hiển thị tại vị trí này. Việc xác định tin hiển thị kế thừa logic hiện tại.

## 2. Scope

### 2.1. In Scope

- Bổ sung thông tin người gửi trên danh sách hội thoại cá nhân và hội thoại nhóm.
- Điều chỉnh hiển thị tin nhắn file trên danh sách hội thoại.
- Bổ sung thể hiện trạng thái thu hồi/xóa trên dòng tin nhắn của danh sách hội thoại.
- Phạm vi dữ liệu bao gồm tin gửi qua Gopany, tin do chính tài khoản đang liên kết gửi từ app Zalo và tin nhận từ khách hàng/thành viên nhóm.
- Áp dụng trên desktop/mobile.

Kế thừa logic xử lý hiện tại về phân quyền, phân công hội thoại, thu hồi/xóa, lưu giữ tin nhắn và đồng bộ dữ liệu. Các thành phần khác của danh sách và chi tiết hội thoại giữ nguyên logic hiện tại, ngoại trừ các thay đổi được mô tả trong tài liệu này.

### 2.2. Out of Scope

- Không hỗ trợ hiển thị ảnh thu nhỏ tại dòng tin nhắn trên danh sách hội thoại.
- Không hỗ trợ icon riêng theo từng loại file trên danh sách hội thoại.
- Không hỗ trợ mở/tải file trực tiếp từ dòng tin nhắn trên danh sách hội thoại.

## 3. Request

| **ID** | **Current Behavior** | **New Behavior** | **Reason** |
|---|---|---|---|
| NR-01 | Tại sidebar danh sách hội thoại, dòng tin nhắn bên dưới tên hội thoại chưa thể hiện người gửi. | Bổ sung thông tin người gửi tại dòng tin nhắn trên danh sách hội thoại.<br><br>• Tin gửi qua Gopany: hiển thị tên nhân sự thực hiện gửi.<br>• Tin do chính tài khoản đang liên kết gửi từ app Zalo: hiển thị tên Zalo của tài khoản gửi.<br>• Tin khách hàng gửi trong hội thoại cá nhân: không thêm tiền tố tên khách hàng.<br>• Tin thành viên khác gửi trong nhóm: hiển thị tên gợi nhớ, nếu chưa có thì dùng tên Zalo.<br>• Tin đã thu hồi/xóa: giữ nội dung và bổ sung nhãn trạng thái tương ứng.<br>• Giữ toàn bộ dòng tin nhắn trên một dòng, áp dụng quy tắc rút gọn tên và nội dung trên desktop/mobile. | Nhận diện người gửi và trạng thái tin nhắn ngay trên danh sách, hỗ trợ phối hợp chăm sóc khách hàng. |
| CR-01 | Trên danh sách hội thoại tại sidebar, dòng tin nhắn file chỉ hiển thị nhãn `[Tệp]`, chưa thể hiện tên file. | Tại dòng tin nhắn file trên danh sách hội thoại, thay nhãn `[Tệp]` bằng icon đính kèm và tên file theo dữ liệu tin nhắn. Nếu không có tên file, giữ nhãn `[Tệp]`. | Nhận diện file đã trao đổi mà không cần mở hội thoại. |

## 4. Business Rules

**Đối chiếu nguồn gửi và cách hiển thị**

| **Nguồn gửi tin** | **Hiển thị trên danh sách** |
|---|---|
| Nhân sự gửi qua Gopany | `{Tên nhân sự thực hiện gửi}: {Nội dung}` |
| Chính tài khoản đang liên kết gửi từ app Zalo | `{Tên Zalo của tài khoản gửi}: {Nội dung}` |
| Khách hàng gửi trong hội thoại cá nhân | `{Nội dung}` |
| Thành viên khác gửi trong nhóm | `{Tên hiển thị của thành viên}: {Nội dung}`. Ưu tiên tên gợi nhớ, nếu chưa có thì dùng tên Zalo. |

Bảng trên thể hiện tin chưa thu hồi/xóa. Với tin đã thu hồi/xóa, nhãn trạng thái được thêm trước nội dung và sau tiền tố nếu có. Tiền tố tiếp tục xác định theo nguồn gửi ban đầu, không thay đổi theo nơi thực hiện thu hồi/xóa hoặc người thực hiện thao tác.

| **ID** | **Nội dung** | **Mô tả** |
|---|---|---|
| BR-01 | Xác định phía gửi | Mỗi hội thoại thuộc về một tài khoản Zalo. Tin gửi đi là tin được gửi bằng chính tài khoản Zalo của hội thoại đó. Tin nhận là tin do khách hàng hoặc thành viên khác trong nhóm gửi đến tài khoản này. Việc xác định phía gửi không phụ thuộc nhân sự đang đăng nhập Gopany. |
| BR-02 | Người gửi qua Gopany | Với tin gửi qua Gopany, hiển thị `{Tên nhân sự}: {Nội dung}` trong cả hội thoại cá nhân và hội thoại nhóm. Tên nhân sự lấy từ thông tin người thực hiện gửi được ghi nhận trên tin nhắn, kế thừa quy tắc tên đang dùng trong chi tiết hội thoại. Mọi nhân sự có quyền xem đều thấy cùng tên người gửi, bao gồm chính người thực hiện gửi. Không lấy người được phân công hội thoại làm người gửi. |
| BR-03 | Tin gửi đi từ app Zalo | Với tin do chính tài khoản Zalo của hội thoại gửi trực tiếp từ app Zalo, sau đó đồng bộ về Gopany, hiển thị `{Tên Zalo của tài khoản gửi}: {Nội dung}` trong cả hội thoại cá nhân và hội thoại nhóm. Tên được lấy từ đúng tài khoản đã gửi tin, kế thừa nguồn tên đang dùng cho tin này trong chi tiết hội thoại. Tên này xác định tài khoản Zalo gửi tin, không xác định nhân sự Gopany thực hiện thao tác trên app. Không dùng tên nhân sự liên kết tài khoản, thực hiện đồng bộ hoặc được phân công hội thoại thay cho tên tài khoản gửi. |
| BR-04 | Tin khách hàng gửi trong hội thoại cá nhân | Với tin khách hàng gửi đến trong hội thoại cá nhân, dòng tin nhắn chỉ hiển thị nội dung, không thêm tiền tố người gửi. |
| BR-05 | Tin thành viên khác gửi trong nhóm | Với tin do thành viên khác gửi vào nhóm, hiển thị `{Tên hiển thị của người gửi}: {Nội dung}`. Ưu tiên tên gợi nhớ, nếu chưa có thì dùng tên Zalo theo quy tắc hiện hành. Tên được lấy theo liên hệ thuộc đúng tài khoản Zalo của hội thoại, không lấy tên gợi nhớ từ liên hệ thuộc tài khoản Zalo khác. |
| BR-06 | Cập nhật tên gợi nhớ | Khi tên gợi nhớ được đặt, đổi hoặc gỡ trong hệ thống, tên người gửi trên dòng tin nhắn trong nhóm cập nhật theo quy tắc tên hiển thị hiện hành. Tên thay đổi trên app Zalo kế thừa cơ chế và thời điểm đồng bộ hiện tại. |
| BR-07 | Người gửi tin trả lời và chuyển tiếp | Với tin trả lời, người gửi là người thực hiện gửi tin trả lời, không phải người gửi của tin được trích dẫn. Với tin chuyển tiếp, người gửi là người thực hiện gửi tin chuyển tiếp vào hội thoại hiện tại, không phải người gửi ban đầu của tin được chuyển tiếp. Tin gửi qua Gopany lấy tên nhân sự thực hiện, tin gửi từ app Zalo của tài khoản đang liên kết lấy tên Zalo tài khoản đó. Tin nhận trong nhóm lấy tên hiển thị của thành viên gửi, tin nhận trong hội thoại cá nhân không thêm tiền tố. |
| BR-08 | Nội dung các loại tin ngoài file | Kế thừa cách hiển thị nội dung hiện tại của text, ảnh, sticker và các loại tin khác ngoài file, bao gồm nhãn `[Hình ảnh]` và `[Sticker]`. Chỉ bổ sung tiền tố người gửi và nhãn thu hồi/xóa khi áp dụng. |
| BR-09 | Tin nhắn file có tên | Thay nhãn `[Tệp]` bằng icon đính kèm và tên file theo dữ liệu tin nhắn. Tiền tố người gửi và nhãn trạng thái áp dụng thống nhất như các loại tin khác. Tên file được hiển thị trong phần nội dung và rút gọn theo không gian còn lại của cả dòng. |
| BR-10 | Tin nhắn file không có tên | Giữ nhãn `[Tệp]` khi dữ liệu tin nhắn không có tên file. Không tự đặt tên file. Tiền tố người gửi và nhãn trạng thái vẫn áp dụng theo các quy tắc tương ứng. |
| BR-11 | Tin đã thu hồi/xóa | Với tin đã thu hồi, tiếp tục hiển thị nội dung cùng nhãn `[Đã thu hồi]`. Với tin đã xóa, tiếp tục hiển thị nội dung cùng nhãn `[Đã xóa]`. Nhãn đặt trước nội dung và sau tiền tố người gửi nếu có. Tin nhận trong hội thoại cá nhân không có tiền tố nên nhãn đứng đầu dòng. |
| BR-12 | Phân biệt người gửi và người thu hồi/xóa | Tiền tố trước nội dung xác định người gửi tin nhắn. Nhãn `[Đã thu hồi]` và `[Đã xóa]` thể hiện trạng thái của tin, không xác định người thực hiện thao tác. Sau khi tin bị thu hồi/xóa, tiền tố vẫn lấy theo người gửi ban đầu, không thay bằng người thực hiện thu hồi/xóa. Áp dụng khi thao tác diễn ra trên Gopany và khi trạng thái từ Zalo được đồng bộ về. Quyền thao tác và cách hiển thị người thực hiện trong chi tiết hội thoại kế thừa logic hiện tại. |
| BR-13 | Cập nhật dòng tin nhắn | Khi hệ thống ghi nhận tin đang hiển thị trên danh sách chuyển sang trạng thái đã thu hồi/xóa, dòng tin nhắn của hội thoại đó cập nhật nhãn tương ứng và giữ nội dung của chính tin đó. Khi có tin tiếp theo được hiển thị theo logic hiện tại, dòng tin nhắn chuyển sang người gửi, nội dung và trạng thái của tin tiếp theo. Nhãn trạng thái của tin trước không được giữ lại cho tin tiếp theo. |
| BR-14 | Thông báo hệ thống | Nội dung thông báo hệ thống trên danh sách kế thừa logic hiện tại, bao gồm thông báo đổi tên nhóm, thêm thành viên và rời nhóm. Không ghép thêm tiền tố người gửi và nhãn thu hồi/xóa theo quy tắc của tin nhắn vào nội dung thông báo. |
| BR-15 | Tên người gửi trên desktop | Không đặt giới hạn ký tự riêng cho tên người gửi. Tên đầy đủ được ghép vào dòng tin nhắn. Nếu cả dòng vượt chiều ngang khả dụng, phần vượt không gian được rút gọn bằng `…`. Tên rất dài có thể bị cắt bởi giới hạn của cả dòng. |
| BR-16 | Tên người gửi trên mobile | Trên mobile, nếu tên người gửi vượt quá 20 ký tự, hiển thị 20 ký tự đầu và thêm `…` trước dấu `: `. Mốc 20 chỉ tính trên tên, không tính dấu `…`, dấu `: `, nhãn trạng thái và nội dung. Áp dụng cho tên nhân sự Gopany, tên Zalo của tài khoản gửi từ app Zalo và tên hiển thị của thành viên nhóm. Khi tên gợi nhớ được cập nhật, áp dụng quy tắc rút gọn cho tên mới. |
| BR-17 | Giới hạn của toàn bộ dòng | Tên người gửi, dấu phân cách, nhãn trạng thái, icon và nội dung cùng nằm trên một dòng, không xuống dòng và không làm tăng chiều cao item. Phần vượt chiều ngang khả dụng được rút gọn bằng `…`. Trên mobile, giới hạn cả dòng áp dụng sau khi đã rút gọn riêng tên người gửi. Mốc 20 ký tự của tên người gửi không áp dụng cho tên file. Khi chiều rộng sidebar thay đổi theo khả năng hiện tại, lượng nội dung hiển thị thay đổi theo chiều rộng khả dụng. |

## 5. UI Spec

| **Thành phần** | **Mô tả** |
|---|---|
| Vị trí | Bổ sung thông tin ngay tại dòng tin nhắn bên dưới tên hội thoại trên danh sách, áp dụng cho desktop/mobile. |
| Thứ tự hiển thị | Người gửi → nhãn trạng thái → nội dung. Tiền tố người gửi có dấu `: ` phía sau. Khi không áp dụng tiền tố hoặc nhãn trạng thái, không hiển thị dấu phân cách và khoảng trống dành cho thành phần đó. |
| Tên người gửi trên desktop | Ghép tên đầy đủ vào dòng, không rút gọn riêng tên theo số ký tự. Cả dòng tiếp tục chịu giới hạn chiều ngang. |
| Tên người gửi trên mobile | Nếu tên người gửi vượt quá 20 ký tự, hiển thị 20 ký tự đầu và thêm `…` trước dấu `: `. Áp dụng cho tên nhân sự, tên Zalo tài khoản gửi từ app và tên hiển thị của thành viên nhóm. |
| Tin nhắn file | Icon đính kèm đặt ngay trước tên file. Dùng một icon đính kèm chung. Nếu không có tên file, hiển thị `[Tệp]`. |
| Giới hạn dòng | Toàn bộ dòng tin nhắn hiển thị trên một dòng. Phần vượt không gian được rút gọn bằng `…`. Không xuống dòng cho tên dài, nhãn trạng thái, nội dung dài hoặc tên file dài. |
| Trạng thái thu hồi/xóa | Thể hiện bằng nhãn trên dòng tin nhắn. Không làm mờ toàn bộ item hội thoại chỉ vì tin đang hiển thị đã thu hồi/xóa. |
| Các thành phần hiện có | Dòng tin nhắn không chồng lấn thời gian và badge chưa đọc. Bố cục, màu sắc, cỡ chữ và cách phân biệt hội thoại đã đọc/chưa đọc kế thừa giao diện hiện tại. |

## 6. Acceptance Criteria

| **ID** | **Scenarios** | **Given** | **When** | **Then** |
|---|---|---|---|---|
| AC-01 | Nhân sự gửi trong hội thoại cá nhân | Hội thoại cá nhân được phân công cho nhân sự A và nhân sự B. Cả hai có quyền xem và gửi tin. | [1] Nhân sự A gửi tin qua Gopany.<br><br>[2] Nhân sự B gửi tin qua Gopany. | [1] Cả A và B thấy tiền tố là tên nhân sự A.<br><br>[2] Cả A và B thấy tiền tố là tên nhân sự B.<br><br>Tiền tố xác định người thực hiện gửi, bao gồm trên giao diện của chính người đó. |
| AC-02 | Nhân sự gửi trong hội thoại nhóm | Nhân sự A và nhân sự B có quyền xem và gửi tin trong cùng hội thoại nhóm. | [1] Nhân sự A gửi tin qua Gopany.<br><br>[2] Nhân sự B gửi tin qua Gopany. | [1] Cả A và B thấy tiền tố là tên nhân sự A.<br><br>[2] Cả A và B thấy tiền tố là tên nhân sự B.<br><br>Không thay tiền tố bằng tên tài khoản Zalo hoặc tên người được phân công hội thoại. |
| AC-03 | Tài khoản đang liên kết gửi từ app Zalo trong hội thoại cá nhân | Nhân sự có quyền xem hội thoại cá nhân thuộc tài khoản Zalo đang liên kết. | Chủ tài khoản gửi tin vào hội thoại bằng chính tài khoản đó trên app Zalo. Tin gửi đi được đồng bộ về Gopany. | Dòng tin nhắn hiển thị `{Tên Zalo của tài khoản gửi}: {Nội dung}`. Tên khớp nguồn tên đang dùng cho tin đó trong chi tiết hội thoại. Không dùng tên nhân sự liên kết tài khoản, thực hiện đồng bộ hoặc được phân công hội thoại. |
| AC-04 | Tài khoản đang liên kết gửi từ app Zalo trong nhóm | Nhân sự có quyền xem nhóm mà tài khoản Zalo đang liên kết là thành viên. | Chủ tài khoản gửi tin vào nhóm bằng tài khoản đang liên kết trên app Zalo. Tin gửi đi được đồng bộ về Gopany. | Dòng tin nhắn hiển thị `{Tên Zalo của tài khoản gửi}: {Nội dung}`. Tiền tố xác định đúng tài khoản đã gửi tin vào nhóm. |
| AC-05 | Khách hàng gửi trong hội thoại cá nhân | Nhân sự có quyền xem hội thoại cá nhân giữa tài khoản Zalo đang liên kết và khách hàng. | Khách hàng gửi tin đến tài khoản đang liên kết. Tin đó được hiển thị trên danh sách hội thoại. | Dòng tin nhắn chỉ hiển thị nội dung, không thêm tiền tố người gửi. |
| AC-06 | Thành viên khác gửi trong nhóm | Nhân sự có quyền xem hội thoại nhóm. Thành viên khác gửi tin trong các trường hợp độc lập.<br><br>[1] Thành viên có tên gợi nhớ.<br><br>[2] Thành viên chưa có tên gợi nhớ. | Thành viên gửi tin vào nhóm. Tin đó được hiển thị trên danh sách hội thoại. | [1] Tiền tố dùng tên gợi nhớ.<br><br>[2] Tiền tố dùng tên Zalo theo quy tắc hiện hành.<br><br>Cả hai trường hợp xác định đúng thành viên gửi tin. |
| AC-07 | Đặt, đổi và gỡ tên gợi nhớ của người gửi | Dòng tin nhắn trong nhóm đang hiển thị tin do thành viên khác gửi. Các thay đổi tên được thực hiện theo logic hiện tại. | [1] Nhân sự đặt tên gợi nhớ cho thành viên chưa có tên gợi nhớ.<br><br>[2] Nhân sự đổi tên gợi nhớ đã có.<br><br>[3] Nhân sự gỡ tên gợi nhớ. | [1] Tên người gửi chuyển từ tên Zalo sang tên gợi nhớ vừa đặt.<br><br>[2] Tên người gửi cập nhật theo tên gợi nhớ mới.<br><br>[3] Tên người gửi trở về tên Zalo.<br><br>Nội dung và định danh người gửi giữ nguyên. Trên mobile, áp dụng lại giới hạn 20 ký tự cho tên đang hiển thị. |
| AC-08 | Phân biệt tài khoản Zalo của từng hội thoại | Danh sách đồng thời có hội thoại thuộc tài khoản Zalo A và B. Cùng một người ngoài đời có liên hệ trên cả hai tài khoản, với tên gợi nhớ khác nhau. | [1] Các liên hệ gửi tin vào nhóm thuộc từng tài khoản.<br><br>[2] Tin do chính tài khoản A và B gửi từ app Zalo được đồng bộ về hội thoại tương ứng. | [1] Tiền tố lấy tên gợi nhớ theo liên hệ thuộc đúng tài khoản của từng hội thoại.<br><br>[2] Tin do A gửi hiển thị tên Zalo của tài khoản A. Tin do B gửi hiển thị tên Zalo của tài khoản B.<br><br>Không lấy tên hoặc nguồn gửi từ hội thoại thuộc tài khoản khác. |
| AC-09 | Người gửi tin trả lời | Tin được gửi là tin trả lời có trích dẫn tin của một người khác. Nhân sự có quyền xem hội thoại tương ứng. | [1] Nhân sự A gửi tin trả lời qua Gopany.<br><br>[2] Khách hàng gửi tin trả lời trong hội thoại cá nhân.<br><br>[3] Thành viên khác gửi tin trả lời trong nhóm. | [1] Tiền tố là tên nhân sự A.<br><br>[2] Không thêm tiền tố tên khách hàng.<br><br>[3] Tiền tố là tên hiển thị của thành viên gửi tin trả lời.<br><br>Không lấy tên người gửi của tin được trích dẫn làm tiền tố. |
| AC-10 | Người gửi tin chuyển tiếp | Tin được gửi là nội dung chuyển tiếp từ tin của một người khác. Nhân sự có quyền xem hội thoại tương ứng. | [1] Nhân sự A chuyển tiếp tin qua Gopany.<br><br>[2] Khách hàng gửi tin chuyển tiếp trong hội thoại cá nhân.<br><br>[3] Thành viên khác gửi tin chuyển tiếp vào nhóm. | [1] Tiền tố là tên nhân sự A.<br><br>[2] Không thêm tiền tố tên khách hàng.<br><br>[3] Tiền tố là tên hiển thị của thành viên gửi tin chuyển tiếp.<br><br>Không lấy tên người gửi ban đầu của tin được chuyển tiếp làm tiền tố. |
| AC-11 | Giữ cách hiển thị các loại tin ngoài file | Dòng tin nhắn đang hỗ trợ text, ảnh, sticker và các loại tin khác ngoài file. | Tin thuộc từng loại được hiển thị trên danh sách hội thoại. | Nội dung giữ cách hiển thị hiện tại, bao gồm nhãn `[Hình ảnh]` và `[Sticker]`. Tiền tố người gửi áp dụng theo nguồn gửi và loại hội thoại, không phát sinh ảnh thu nhỏ mới. |
| AC-12 | Tin nhắn file có tên | Tin nhắn file có tên file trong dữ liệu tin nhắn. | Tin file được hiển thị trên danh sách hội thoại. | Hiển thị icon đính kèm và đúng tên file theo dữ liệu, thay nhãn `[Tệp]`. Tiền tố người gửi áp dụng theo nguồn gửi và loại hội thoại. Tên file dài được rút gọn theo không gian của cả dòng, không cắt riêng ở mốc 20 ký tự. |
| AC-13 | Tin nhắn file không có tên | Dữ liệu tin nhắn file không có tên file. | Tin file được hiển thị trên danh sách hội thoại. | Giữ nhãn `[Tệp]`, không tự đặt tên file và không hiển thị giá trị `null` hoặc `undefined`. Tiền tố người gửi tiếp tục áp dụng theo nguồn gửi và loại hội thoại. |
| AC-14 | Thu hồi trên Gopany đối với tin gửi qua Gopany | Nhân sự A đã gửi tin qua Gopany. Tin của A đang hiển thị trên danh sách. A được phép thu hồi tin này theo logic hiện tại. | A thu hồi tin của mình trên Gopany. Hệ thống ghi nhận thu hồi thành công. | Dòng tin nhắn hiển thị tên nhân sự A, nhãn `[Đã thu hồi]` và nội dung của tin đó. Tiền tố xác định người gửi, nhãn xác định trạng thái tin. |
| AC-15 | Thu hồi trên app Zalo đối với tin gửi từ app Zalo | Tin do chính tài khoản đang liên kết gửi trên app Zalo đã đồng bộ về Gopany. Dòng tin nhắn đang hiển thị tiền tố tên Zalo của tài khoản gửi. | Chủ tài khoản thu hồi tin đó trên app Zalo. Trạng thái thu hồi được đồng bộ về Gopany. | Dòng tin nhắn hiển thị `{Tên Zalo của tài khoản gửi}: [Đã thu hồi] {Nội dung}`. Tiền tố tiếp tục xác định tài khoản gửi tin. Không gán nhân sự Gopany làm người thực hiện thao tác trên app Zalo. |
| AC-16 | Thu hồi trên Gopany đối với tin gửi từ app Zalo | Tin gửi đi từ app Zalo đã đồng bộ về Gopany và đang hiển thị tiền tố tên Zalo của tài khoản gửi. Nhân sự A được phép thu hồi tin này theo logic hiện tại. | Nhân sự A thu hồi tin trên Gopany. Hệ thống ghi nhận thu hồi thành công. | Dòng tin nhắn hiển thị `{Tên Zalo của tài khoản gửi}: [Đã thu hồi] {Nội dung}`. Không thay tiền tố bằng tên nhân sự A. Thông tin người thực hiện thu hồi trong chi tiết hội thoại kế thừa logic hiện tại. |
| AC-17 | Thu hồi trên app Zalo đối với tin gửi qua Gopany | Nhân sự A đã gửi tin qua Gopany bằng tài khoản Zalo đang liên kết. Tin đang hiển thị trên danh sách với tiền tố tên nhân sự A. | Chủ tài khoản thu hồi chính tin đó trên app Zalo. Hệ thống đồng bộ trạng thái thu hồi về Gopany. | Tiền tố vẫn là tên nhân sự A, thêm nhãn `[Đã thu hồi]` và giữ nội dung tin. Không đổi tiền tố sang tên tài khoản Zalo chỉ vì thao tác thu hồi diễn ra trên app Zalo. |
| AC-18 | Khách hàng thu hồi tin trong hội thoại cá nhân | Tin do khách hàng gửi đang hiển thị trên danh sách hội thoại cá nhân. | Khách hàng thu hồi tin trên Zalo. Hệ thống ghi nhận trạng thái thu hồi. | Dòng tin nhắn hiển thị `[Đã thu hồi] {Nội dung}`, không thêm tiền tố người gửi. |
| AC-19 | Thành viên nhóm thu hồi tin đã gửi | Tin do thành viên khác gửi vào nhóm đang hiển thị trên danh sách với tên của thành viên đó. | Thành viên thu hồi tin của mình trên Zalo. Hệ thống ghi nhận trạng thái thu hồi. | Dòng tin nhắn tiếp tục có tên hiển thị của thành viên gửi, thêm nhãn `[Đã thu hồi]` và giữ nội dung của tin đó. Tên áp dụng quy tắc tên gợi nhớ và quy tắc desktop/mobile hiện hành. |
| AC-20 | Tin đang hiển thị chuyển sang trạng thái đã xóa | Tin đang hiển thị trên danh sách có thể thuộc nguồn gửi qua Gopany, gửi đi từ app Zalo, nhận từ khách hàng hoặc nhận từ thành viên nhóm. | Hệ thống ghi nhận trạng thái đã xóa của chính tin đang hiển thị theo logic hiện tại. | Dòng tin nhắn thêm nhãn `[Đã xóa]` và giữ nội dung của tin đó. Tiền tố giữ theo người gửi ban đầu, nguồn gửi và loại hội thoại. Không thay tiền tố bằng tên người thực hiện xóa. |
| AC-21 | Có tin tiếp theo sau tin đã thu hồi/xóa | Dòng tin nhắn đang hiển thị một tin đã thu hồi/xóa. | Tin tiếp theo chưa thu hồi/xóa được hiển thị theo logic hiện tại. | Dòng tin nhắn chuyển sang người gửi và nội dung của tin tiếp theo. Không giữ nhãn thu hồi/xóa của tin trước. |
| AC-22 | Thông báo hệ thống | Thông báo đổi tên nhóm, thêm thành viên hoặc rời nhóm được hiển thị trên danh sách theo logic hiện tại. | Danh sách cập nhật thông báo đó. | Nội dung thông báo kế thừa logic hiện tại. Không thêm tiền tố người gửi hoặc nhãn trạng thái theo quy tắc của tin nhắn vào thông báo. |
| AC-23 | Tên người gửi dài trên desktop | Dòng tin nhắn có tiền tố tên người gửi dài hơn 20 ký tự. Tên có thể là tên nhân sự Gopany, tên Zalo tài khoản gửi từ app hoặc tên hiển thị của thành viên nhóm. Các trường hợp độc lập.<br><br>[1] Chiều ngang khả dụng đủ hiển thị cả dòng.<br><br>[2] Chiều ngang khả dụng không đủ hiển thị cả dòng. | Nhân sự xem dòng tin nhắn trên desktop. | [1] Tên hiển thị đầy đủ, không thêm `…` chỉ vì tên vượt 20 ký tự.<br><br>[2] Giữ một dòng, rút gọn phần vượt chiều ngang bằng `…`. Tên rất dài có thể bị cắt theo giới hạn cả dòng, không áp dụng giới hạn 20 ký tự riêng cho tên. |
| AC-24 | Giới hạn tên người gửi trên mobile | Tên đã được xác định theo người gửi thực tế. Các trường hợp độc lập áp dụng cho tên nhân sự Gopany, tên Zalo tài khoản gửi từ app và tên hiển thị của thành viên nhóm.<br><br>[1] Tên dưới 20 ký tự.<br><br>[2] Tên đúng 20 ký tự.<br><br>[3] Tên trên 20 ký tự. | Nhân sự xem dòng tin nhắn trên mobile tại chiều ngang đủ hiển thị tiền tố và một phần nội dung. | [1] Giữ nguyên tên, không thêm `…` vào tên.<br><br>[2] Giữ đủ 20 ký tự, không thêm `…` vào tên.<br><br>[3] Hiển thị 20 ký tự đầu của tên, thêm `…`, sau đó thêm `: ` và nội dung.<br><br>Dấu `…`, dấu `: `, nhãn trạng thái và nội dung không được tính vào mốc 20 ký tự của tên. |
| AC-25 | Toàn bộ dòng vượt không gian hiển thị | Dòng tin nhắn có tên người gửi, nhãn trạng thái và nội dung dài. Nội dung bao gồm text và tên file. Tên trên mobile đã được xử lý theo giới hạn 20 ký tự. | Nhân sự xem danh sách tại chiều ngang không đủ hiển thị toàn bộ dòng trên desktop/mobile. | Cả dòng giữ trên một dòng, phần vượt không gian được rút gọn bằng `…`. Không xuống dòng, không làm tăng chiều cao item, không chồng lấn thời gian và badge chưa đọc. Không thêm quy tắc rút gọn riêng tên file ở mốc 20 ký tự. |
| AC-26 | Hội thoại đã đọc và chưa đọc | Nhân sự có hội thoại đã đọc và hội thoại chưa đọc trong danh sách, đang sử dụng quyền xem và bộ lọc hiện tại. | Danh sách hiển thị người gửi, tên file và cập nhật trạng thái thu hồi/xóa. | Cả hội thoại đã đọc và chưa đọc đều áp dụng quy tắc hiển thị mới. Việc bổ sung thông tin hiển thị không tự thay đổi quyền xem, kết quả lọc, badge chưa đọc và thứ tự hội thoại. |

Các AC áp dụng trên desktop/mobile, ngoại trừ AC-23 dành cho desktop và AC-24 dành cho mobile. Các trường hợp thu hồi/xóa áp dụng cho các loại tin hiện hỗ trợ, bao gồm text, ảnh, sticker và file. Với file đã thu hồi/xóa, có tên file thì tiếp tục hiển thị icon đính kèm và tên file, không có tên file thì giữ `[Tệp]`.

## 7. Data Migration

Cách hiển thị mới áp dụng cho tin đã có trước triển khai và tin phát sinh sau triển khai, bao gồm tin gửi qua Gopany, tin gửi đi từ app Zalo, tin nhận từ khách hàng/thành viên nhóm, tin file và tin đã thu hồi/xóa. Tin lịch sử được hiển thị theo thông tin người gửi, nguồn gửi, nội dung và trạng thái hiện có. Tin gửi qua Gopany lấy tên nhân sự thực hiện gửi. Tin do chính tài khoản đang liên kết gửi từ app Zalo lấy tên Zalo của tài khoản gửi, kế thừa nguồn tên dùng trong chi tiết tin nhắn. Không yêu cầu phát sinh thêm tin nhắn để áp dụng cách hiển thị mới.

Tên thành viên nhóm sử dụng tên gợi nhớ hiện hành, nếu chưa có thì dùng tên Zalo. Tên người gửi áp dụng quy tắc rút gọn của desktop/mobile. Tin file lịch sử có tên file được hiển thị icon đính kèm và tên file, không có tên file thì giữ `[Tệp]`.

Không chuyển đổi nội dung tin nhắn lịch sử, chỉnh sửa file nguồn hoặc thay đổi trạng thái thu hồi/xóa. Không gán bổ sung nhân sự gửi cho tin lịch sử từ app Zalo. Các quyền truy cập, dữ liệu phân công và cơ chế đồng bộ hiện tại được giữ nguyên.

## 8. Change Log

| **Version** | **Date** | **Description / Change** | **Reason** |
|---|---|---|---|
