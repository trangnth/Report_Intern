## Ghi chú một vài câu lệnh trong qua trình tìm hiểu

Trong `vim` nếu muốn thêm `#` để comment các dòng từ dòng 1 tới dòng 10 thì dùng lệnh sau (trong chế độ normal của vi/vim):

	:1,10s/^/#

Hiển thị một file mà trừ các dòng comment hoặc dòng trắng:

	cat /etc/libvirt/libvirtd.conf | egrep -v "^$|^#"