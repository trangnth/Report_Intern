## Grep command

Grep mặc định là có phân biệt chữ in hoa và in thường, dưới đây là một số các trường hợp sử dụng command `grep`

1. Tìm kiểm dòng chứ một chuỗi ký tự nào đó trong một file

		grep "literal_string" filename

2. Tìm kiểm dòng chứ một chuỗi ký tự nào đó trong nhiều file

		grep "string" FILE_PATTERN

	Ví dụ tìm kiểm từ `this` trong tất cả các file bắt đầu bằng cụm `demo_`:

		grep "this" demo_*

3. Tìm kiếm các dòng trong file có chuỗi `string` nhưng không phần biệt in hoa hay in thường

		grep -i "string" FILE

4. Match regular expression in files

		grep "REGEX" filename

	Một số các Regex có thể sử dụng cho grep:

	* ? The preceding item is optional and matched at most once.
	* \* The preceding item will be matched zero or more times.
	* \+ The preceding item will be matched one or more times.
	* {n} The preceding item is matched exactly n times.
	* {n,} The preceding item is matched n or more times.
	* {,m} The preceding item is matched at most m times.
	* {n,m} The preceding item is matched at least n times, but not more than m times.

Một ví dụ về sự khác nhau giữa `?` và `*` [ở đây](https://askubuntu.com/questions/822779/difference-between-and-in-regular-expressions)

5. Checking for full words, not for sub-strings using grep -w

	Để hiểu được chuỗi muốn tìm là một từ tách biệt (không nằm trong từ khác) thì sử dụng thêm tùy chọn `w`, ví dụ:

		grep -iw "is" demo_file

6. Grep OR Operator:

		grep 'pattern1\|pattern2' filename

	hoặc

		grep -E 'pattern1|pattern2' filename

	hoặc

		egrep 'pattern1|pattern2' filename

	hoặc

		grep -e pattern1 -e pattern2 filename

7. Grep AND Operator:

	* Sử dụng `-E`
	
	```sh
	# match với tất cả các line có pattern1 theo sau đó là bất cứ thứ gì nhưng phải có pattern2 trong đó
	grep -E 'pattern1.*pattern2' filename
	# match với tất cả các dòng có cả hai parttern1 và partten2
	grep -E 'pattern1.*pattern2|pattern2.*pattern1' filename
	```

	* Sử dụng Multiple grep command

		grep -E 'pattern1' filename | grep -E 'pattern2'

8. Grep NOT Operator

	Match với tất cả các dòng không có chuỗi `pattern1`
		
		grep -v 'pattern1' filename

	Hoặc cũng có thể sử dụng egrep kết hợp

		egrep 'Manager|Developer' employee.txt | grep -v Sales

	Hoặc ví dụ muốn loại bỏ toàn bộ các dòng trắng và các dòng bắt đầu bằng `#`:

		cat /etc/libvirt/libvirtd.conf | egrep -v "^$|^#"




## Tham khảo

[1] https://www.thegeekstuff.com/2011/10/grep-or-and-not-operators/

[2] https://www.thegeekstuff.com/2009/03/15-practical-unix-grep-command-examples/

[3] https://www.thegeekstuff.com/2011/01/advanced-regular-expressions-in-grep-command-with-10-examples-%E2%80%93-part-ii/