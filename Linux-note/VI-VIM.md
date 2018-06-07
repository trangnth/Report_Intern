# VI/VIM

VI hay VIM.

Vim là từ Vi cải tiến nên cơ bản là chúng giống nhau.

**Vậy Vi/Vim là gì, tại sao phải sử dụng nó**

Vi/Vim chỉ là một text editor. Giống như các text editor quen thuộc khác như Notepad, Sublime Text, Atom,... Vim cũng chỉ là một chương trình cho phép người dùng soạn thảo và chỉnh sửa nó tùy ý.

Đều có 3 mode chính: 

* Insert mode
* Normal mode
* Visual mode


** Giữa Vi và Vim có một số sự khác biệt cơ bản: **

* Portability: Vi chỉ có thể dùng trên Unix, thay vào đó thì Vim có làm việc trên cả MS-Windows, Macintosh, Amiga, OS/2, VMS, QNX và nhiều hệ thống khác. Tất nhiên Vim cũng có thể dùng trên tất cả các Unix system.

* syntax highlighting: Vim được lập trình để làm nổi bật các thành phần với các color và style khác nhau dựa trên từng loại file đang được chỉnh sửa. Có hàng trăm các quy tắc syntax highlighting đi kèm với Vim trong khi Vi thì không


** Cấu trúc câu lệnh của Vim **

	[number][command][motion/ text object]

`number` là số lần thực hiện câu lệnh, mặc định là 1.

`command` là các hành động như thêm, sửa, xóa, thay thế,.. 

`Motion / Text object`: Vim coi các text trong file như một object, ví dụ như 1 từ, 1 câu,.. và có thể thao tác với mỗi object đo

Ví dụ như: 

* Bạn muốn xóa 1 từ: daw (delete a word)
* Bạn muốn thay thế nội dung trong dấu "": ci" (change in "")
* Xóa từ vị trí con trỏ tới cuối file: dG (delete to G-eof)
* Copy nội dung cho tới lúc gặp dấu ".": yf. (yank (to) find .)
* Bạn muốn di chuyển con trỏ xuống dưới 10 dòng: 10j


