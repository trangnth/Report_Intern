## Bash shell programming

**Shell** là một chương trinh soạn thảo cung cấp giao diện người dùng với các của sổ terminal. Nó cũng thường được sử dụng để chạy các đoạn script, thậm chí cả các phiên không tương tác mà không có cửa sổ terminal, khi các lệnh được gõ trức tiếp.

	#!/bin/bash
	find /usr/lib -name "*.c" -ls

Dòng đầu tiên của script sẽ bắt đầu với `#!/bin/bash` chứa toàn bộ đường dẫn của trình thông dịch được sử dụng trên file.Trình thông dịch có nhiệm vụ thực thi các yêu cầu trong script. Một số trình thông dịch phổ biến được sử dụng :

	/usr/bin/perl
	/bin/bash
	/bin/csh
	/bin/tcsh
	/bin/ksh
	/usr/bin/python
	/bin/sh

Tất cả các shell script đều trả về các giá trị khi thực hiện. Nếu thành công sẽ trả về 0, không thành công sẽ trả về một số khác không, và mọi giá trị trả về đều được lưu trong biến môi trường `$?` sử dụng `echo` để xem.

### Một số các cú pháp cơ bản

|Kí tự|	Mô tả|
|--|--|
|#	|Sử dụng để thêm bình luận, trừ khi dùng như # hoặc #! là để bắt đầu một script|
|\\	|sử dụng ở cuối dòng để chỉ ra rằng dòng lệnh vẫn tiếp tục xuống các dòng dưới|
|;|	Sử dụng để thông dịch những lệnh tiếp sau|
|$|	chỉ ra rằng đó là một biến|

Thường thì mỗi lệnh sẽ một dòng, nếu viết chúng trên một dòng thì dùng dấu `;` để phiên cách. 

Nếu dùng `&&` để nối các câu lệnh thì lệnh vẫn được thực hiện tuần tự, nhưng nếu có một lệnh bất kỳ sai thì cả dòng bị hủy bỏ.

Còn nếu dùng `||` thì nếu lệnh đầu lỗi thì các lệnh theo sau đó sẽ không được thực thi. 

Trường hợp này sẽ chạy các câu lệnh cho tới khi có một lệnh nào đó thành công thì dừng thực thi các lệnh sau đó

### Functions

Một hàm là một khối các mã lệnh thực thi nhiều tiến trình. Hàm rất hưu ích cho việc thực hiện các thủ tục nhiều lần.

Hàm còn được gọi là các chương trình con. Sử dụng hàm trong script có hai bước: 

1. Khai báo hàm
2. Gọi hàm

Cấu trúc cơ bản của việc khai báo hàm:

```sh
function_name () {
   command...
}
```

Hàm không giới hạn số dòng và số câu, nó có thể được gọi bất cứ khi nào cần thiết. Dưới đây sẽ chỉ ra làm thế nào để đưa các tham số vào một hàm. Các tham số tương ứng theo thứ tự $1, $2, $3,... Tên của script là $0, tất cả các tham số được truyền vào là $* và số các đối số là $#.

```sh
# cat script.sh
#!/bin/bash
echo The name of this program is: $0
echo The first argument passed from the command line is: $1
echo The second argument passed from the command line is: $2
echo The third argument passed from the command line is: $3
echo All of the arguments passed from the command line are : $*
echo All done with $0
exit 0
#
# ./script.sh A B C
The name of this program is: ./script.sh
The first argument passed from the command line is: A
The second argument passed from the command line is: B
The third argument passed from the command line is: C
All of the arguments passed from the command line are : A B C
All done with ./script.sh
```

### Command substitution (Lệnh thay thế)

Bạn có thể cần sử dụng kết quả của lệnh này như là biến của lệnh khác, điều này có thể thực hiện bằng cách sau :

1. Kết thúc câu lệnh bằng ()
2. Kết thúc câu lệnh innner bằng $()

Bất kể là phương thức nào thì câu lệnh inner cũng sẽ được chạy trong một môi trường shell mới. Đầu ra của shell sẽ được chèn vào nơi mà bạn thực hiện lệnh thay thế. Hầu hết các lệnh đều thực hiện được theo cách này. Lưu ý rằng phương pháp thứ 2 sẽ cho phép thực hiện các lệnh lồng nhau.

### The if statement

Cấu trúc 

	if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi

hoặc:

	if condition
	then
	       statements
	else
	       statements
	fi	

Ví dụ:

	$ cat ./count.sh
	#!/bin/bash
	if [ -f $1 ]
	then
	    echo "The " $1 " contains " $(wc -l < $1) " lines.";
	    echo $?
	fi
	& ./count.sh /etc/passwd
	The  /etc/passwd  contains  35  lines.
	0

Có một số tùy chọn để check file như sau:

|Option|	Action|
|-------|---------|
|-e file|	Check if the file exists.|
|-d file|	Check if the file is a directory.|
|-f file|	Check if the file is a regular file.|
|-s file|	Check if the file is of non-zero size.|
|-g file|	Check if the file has sgid set.|
|-u file|	Check if the file has suid set.|
|-r file|	Check if the file is readable.|
|-w file|	Check if the file is writable.|
|-x file|	Check if the file is executable.|

Bạn có thể so sánh các string với nhau:

	if [ string1 == string2 ]
	then
	   ACTION
	fi

Nếu so sánh các số:

	if [ exp1 OPERATOR exp2 ]
	then
	   ACTION
	fi

Các tùy chọn cho operator

|Operator|	Action|
|--------|--------|
|-eq	|Equal to - bằng với|
|-ne	|Not equal to - không bằng với|
|-gt|	Greater than - lớn hơn|
|-lt|	Less than - nhỏ hơn|
|-ge	|Greater than or equal to - lớn hơn hoặc bằng|
|-le|	Less than or equal to - nhỏ hơn hoặc bằng|