# Supervisor

Supervisor là một hệ thống client/server cho phép người dùng của nó kiểm soát một số quy trình trên các hệ điều hành tương tự với UNIX. 

Một số tiện ích:

* Thuận tiện để chạy một vài thứ như một process. Đảm bảo các process luôn luôn được chạy, nếu process nào đó bị tắt thì sẽ khởi động lại.

* Tự động khởi chạy các process được quản lý cùng hệ thống.

* Quản lý tập trung nhiều process dưới dạng các group process và có thể bật tắt chúng cùng lúc.



Đặc điểm:

* Đơn giản: supervisor được cấu hình thông qua kiểu cấu hình đơn giản INI nên rất dễ để đọc và học. Nó cung cấp nhiều tùy chọn cho mỗi process, giúp công việc restart các process failed và tự động rotation log.
* Tập trung
* Hiệu quả
* Mở rộng
* Tương thích 
* Proven


Supervisor có hai thành phần chính:

**supervisord**: 

* chịu trách nhiệm start các chương trình con theo yêu cầu riêng của mình, phản hồi lại các command từ clients, khởi động lại các tiến trình con bị crashed hoặc exited, logging lại các `stdout` và `stderr` output của các tiền trình con, tạo và xử lý các "events" tương ứng với các điểm trong vòng đời của các tiến trinh con.

*  Các tiến trình trên server sử dụng một file cấu hình được đặt tại `/etc/supervisord.conf`. Đây là một file cấu hình có kiểu `Windows-INI`. Quan trọng là làm thế nào để giữ an toàn cho file này qua các permissions của hệ thống bởi nó có thể chứa username, password của người dùng mà không được mã hóa.

**supervisorctl**

* Nó cung cấp một giao diện tương tự với shell để thao tác với các tính năng được cung cấp bởi `supervisord`. Với supervisorctl, một user có thể được kết nối tới các tiến trình supervisord khác (một kết nối một thời điểm), nhận các status trên các tiến trình con được kiểm soát, stop và start các tiến trình con và nhận danh sách các tiến trình của supervisord.

* Command-line client nói chuyện với server thông qua một UNIX domain socket hoặc một internet socket (TCP). Server có thể yêu cầu user của một client xuất trình thông tin xác thực trước khi cho phép user đó thực hiện các commands. Tiến trình của client thường được sử dụng file cấu hình giống với server.



**Cài đặt**

```sh
yum install supervisor -y
# or
pip install supervisor
```
		


### Command supervisorctl

* supervisorctl Command-Line Options

|option | Describe |
|--|--|
|-c, --configuration	| Configuration file path (default /etc/supervisord.conf)|
|-h, --help	| Print usage message and exit|
|-i, --interactive	| Start an interactive shell after executing commands|
|-s, --serverurl URL	| URL on which supervisord server is listening (default “http://localhost:9001”).|
|-u, --username	| Username to use for authentication with server|
|-p, --password	| Password to use for authentication with server|
|-r, --history-file	| Keep a readline history (if readline is available)|
| action [arguments] | Actions are commands like “tail” or “stop”. If -i is specified or no action is specified on the command line, a “shell” interpreting actions typed interactively is started. Use the action “help” to find out about available actions.| 

* supervisorctl Actions


### File cấu hình 

**Tạo file cấu hình mặc định**

* Sử dụng command `echo_supervisord_conf` để in ra file cấu hình mẫu
* File cấu hình thường được đặt tại `/etc/supervisord.conf`
* Nếu file cấu hình được đặt tại một vị trí khác thì khởi động supervisor với tùy chọn `-c` để chỉ ra đường dẫn tới file cấu hình

```sh
supervisord -c /home/trangnth/supervisord.conf
```

File cấu hình của supervisor là một Windows-INI-style (Python ConfigParser) file. Nó gồm có nhiều sections (mỗi section được đánh dấu bắt đầu bởi một header dạng `[header]`) và các cặp key/value pairs trong các sections đó. 




## Tham khảo 

[1] http://supervisord.org/
