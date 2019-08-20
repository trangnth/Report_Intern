## Ghi chép về awk

Luồng hoạt động:

* Scans một file theo từng dòng một
* Chia nhỏ mỗi dòng thành nhiều cột
* So sánh các dòng/cột với các các pattern
* Thực hiện hành động đối với các dòng matched

Hữu ích cho:

* Transform data files
* Tạo ra các định dạng báo cáo

Cấu trúc sử dụng cơ bản:

	awk '/search pattern 1/ {Actions} /search pattern 2/ {Actions}' file

### Một số các trường hợp sử dụng cơ bản

* In toàn bộ file ra màn hình:

		awk '{print}' employee.txt

* In các dòng có từ `manager`

		awk '/manager/ {print}' employee.txt 

* Chi dòng ra làm nhiều cột, in cột thứ 1 và thứ 4 trong các dòng

		awk '{print $1,$4}' employee.txt 




## Tham khảo

[1] https://www.geeksforgeeks.org/awk-command-unixlinux-examples/

[2] https://viblo.asia/p/tim-hieu-awk-co-ban-gGJ59229KX2

[3] https://viblo.asia/p/tim-hieu-ve-ngon-ngu-lap-trinh-awk-cach-su-dung-awk-trong-bash-script-yMnKMJDAZ7P