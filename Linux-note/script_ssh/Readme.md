## Hướng dẫn chạy script 

Miêu tả code: Script được viết ra để sinh ra một cặp key cho ssh, sau đó copy public key lên server và sử dụng private key để đăng nhập

* Version 1: nhập ip, username và password của server mà bạn muốn login bằng tay khi script chạy

* Version 2: Nhâp ip, username và password tương ứng cho mỗi server từ một file có sẵn.

#### Cách chạy script

* B1: Download script về
* B2: Phân quyền cho file script để chạy
		
		chmod 777 ssh_gen_key_v2.sh

* B3:

	* Version 1: Nhập ip, username và password của server vào.

	* Version 2: Bạn tạo một file tên là list_of_servers.txt chứa ip, username và password tương ứng cho mỗi server có cấu trúc như sau: 

		192.168.60.134 trang 1
		192.168.60.129 trangnth abc

* B4: Finished. Đăng nhập vào server theo câu lệnh đưa ra trên màn hình