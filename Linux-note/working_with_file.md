### The File Stream

Khi các dòng lệnh được thực thi, mặc định sẽ có 3 luồng file chuẩn:

* standard input or stdin
* standard output or stdout
* standard error or stderr

Thông thường, stdin là những gì bạn nhập từ bàn phím, stdout và stderr sẽ được in ra terminal; thường stderr sẽ được chuyển hướng tới file log ghi lỗi. stdin thường được cung cấp từ các điểu khiển đầu vào hoặc output của lệnh trước đó thông qua đường ống. stdout cũng thường được chuyển hướng vào file. Từ khi stderr là nơi mà các error messages được viết thì thường không có gì ở đó.

File descriptors trong Linux có các quy ước: 0 là stdin, 1 là stdout, 2 là stderr. 

Chúng ta có thể chuyển hướng 3 standard filestreams nên có thể lấy inout từ một file hoặc một command khác thay vì từ bàn phím, và chúng ta cũng có thể viết output và error ra file or send chúng như một input của lệnh tiếp theo. Ví dụ, có một chương trình được gọi là `do_something` có thể đọc stdin và viết stdout, stderr, chúng ta sẽ thay đổi input source:

	$ do_something < input-file

Nếu bạn muốn gửi output tới file:

	$ do_something > output-file

Bạn có thể pipe output của một command hoặc program khác như một input

	$ command1 | command2 | command3

### Search for file

Tiện ích `locate` thực hiện tìm kiếm thông qua cơ sở dữ liệu của file và thư mục được xây dựng trước đó trên hệ thống của bạn, matching với tất cả các mục có chưa chuỗi ký tự được chỉ định. `locate` sử dụng database được tạo bởi một chương trình khác là `updatedb`. Hầu hết các hệ thống linux đều chạy tự động mỗi ngày một lần. Tuy nhiên, bạn có thể update bất cứ lúc nào bằng việc chạy `updatedb` với user root

```sh
sudo apt-get install -y mlocate
sudo updatedb
sudo locate zip
```

Một ví dụ muốn tìm tất cả các file có đường dẫn chứa từ `zip` và trong danh sách outout từ lệnh trên, hiển thị tất cả các dòng có chứ từ `bin` để rút ngắn danh sách đó, ta sẽ đưa vào pipe như sau: 

```sh
$ locate zip | grep bin
/bin/bunzip2
/bin/bzip2
/bin/bzip2recover
/bin/gunzip
/bin/gzip
/home/trang/backup-mgmt/backup/app/static/vendors/jszip/documentation/examples/get-binary-files-ajax.html
/usr/bin/gpg-zip
/usr/bin/zipdetails
/usr/lib/klibc/bin/gunzip
/usr/lib/klibc/bin/gzip
```

`wildcards` được sử dụng để search cho các filename bao gồm các ký tự đặc biệt

| Wildcards | Result |
|-----------|--------|
| ? | Matches bất kỳ một ký tự đơn nào |
| * | Matches bất kỳ một chuỗi ký tự nào |
| [set] | Khớp với bất kỳ ký tự nào nằm trong tập ký tự [set] |
| [!set] | Khớp với bất kỳ ký tự nào không nằm trong tập [set] |

Ví dụ liệt kê tất cả các file bắt đầu bằng bất ký chuỗi nào nhưng có kết thúc sau dấu `.` có 3 ký tự bất kỳ

```sh
$ ls *.???
ba.bka  file1.txt  file2.txt  file4.txt  file5.txt  file6.txt  haha.bks
```

Liệt kê tất cả các file chứ ít nhất một ký tự trong khoảng từ 0-9

```sh
$ ls *[0-9]*
file1.txt  file2.txt  file4.txt  file5.txt  file6.txt
```

Liệt kê tất cả các file không bắt đầu bằng ký tự `f`

```sh
$ ls [!f]*
aa  asss  ba.bka  haha.bks
```

`find` cực kỳ hữu dụng và thường được sử dụng trong cuộc sống hằng ngày của quản Linux system admnistrator. Muốn tìm tất cả các file có phần mở rộng là `.log` trong thư mục `/var` sử dụng lệnh sau:

	find /var -name *.log

Khi không có đối số, `find` sẽ list tất cả các file trong thư mục hiện tại và trong tất cả các các thư mục con của nó. 

Tìm kiếm các file hoặc thư mục tên là `haha`

```sh
$ find /home/trang -name haha
/home/trang/test/folder/haha
/home/trang/test/haha
```

Thêm tùy chọn `-type d` để chỉ tìm các thư mục hoặc `-type f` để chỉ tìm các file và `-type l` là symbolic links có tên `haha` 

```sh
$ find /home/trang -type d -name haha
/home/trang/test/folder/haha
```

Để tìm kiếm và xóa tất cả các file kết thúc là `.swp`: 

```sh
$ find -name "*.swp" -exec rm {} ’;’
$ find -name "*.swp" -ok rm {} \;
``` 

Nếu muốn sắp xếp kết quả tìm kiếm theo các thuộc tính như ngày được tạo, lần sử dụng cuối cùng,... hoặc dựa trên kích thước

* Tìm kiếm dựa trên thời gian. Tìm tất cả các file có trạng thái thay đổi lần cuối trong 3 ngày trước

		$ find / -ctime 3

* Tìm kiếm dựa trên kích thước file, tìm kiếm các file có kích thước lớn hơn 10MB

		$ find / -size +10M

### Manage files

| Command | Usage |
|---------|-------|
| cat |	Sử dụng để xem các file không quá dài |
| tac | Sử dụng để xem các file từ cuối lên, bắt đầu là dòng cuối cùng |
| less | Sử dụng để xem các chương trình lớn hơn vì nó cho phép phân trang |
| tail | Mặc định sẽ show ra 10 dòng, nếu muốn xem nhiều hơn thêm tùy chọn `n 15` |
| head | Ngược lại với `tail`, show ra 10 dòng đầu tiên của file |


`touch` ngoài việc tạo ra một file mới, thì `touch` còn dùng để set hoặc update các thời gian access, change và modify của files.

Set thời gian cho file với time stamp 4 p.m, March 20th (03 20 1600)

	touch -t 03201600 <filename>

`mkdir` tạo một thư mục, `rmdir` xóa một thư mục, nếu thư mục không rỗng sử dụng lệnh `rm -rf <thư muc>`. Cận thận khi dùng lệnh này với thư mục root (/)

### Compare file

Sử dụng `diff` để so sánh nội dung các file và  thư mục

