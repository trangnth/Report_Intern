# NUTTCP

Nuttcp là một công cụ đo lường hiệu suất mạng được sử dụng bởi các nhà quản trị mạng và quản trị hệ thống.

Cách sử dụng cơ bản nhất của nó là xác định thông lượng lớp mạng TCP hoặc UDP bằng cách chuyển bộ nhớ đệm từ hệ thống nguồn qua mạng tới hệ thống đích, hoặc truyền dữ liệu trong một khoảng thời gian đã xác định, hoặc chuyển một số đã chỉ định byte.

Ngoài việc báo cáo luồng dữ liệu đạt được bằng Mbps, nuttcp cũng cung cấp thêm thông tin hữu ích liên quan đến việc truyền dữ liệu như user, system, wall-clock time, mức độ sử dụng của CPU, tỷ lệ mất mát dữ liệu (đối với UDP).


### Cài đặt vào sử dụng

#### Cài đặt

CentOS
	
	yum install nuttcp

Ubuntu
	
	apt-get install nuttcp

	
### Các option chính

| Options | Descriptions |
|---------|--------------|
| -h | Các options có thể sử dụng |
| -V | Hiển thị thông tin về phiên bản |
| -t | Chỉ định máy transmitter |
| -r | Chỉ định máy receiver |
| -S | Chỉ định máy server |
| -1 | Giống với '-S' |
| -b | Định dạng output theo kiểu one-line |
| -B | Buộc receiver phải đọc toàn bộ buffer |
| -u | Sử dụng UDP (mặc định là TCP) |
| -v | Cung cấp thêm thông tin |
| -w | window size |
| -p | port sử dụng để kết nối dữ liệu, mặc định là 5001 |
| -P | với mode client-server, đây là port để kiểm soát kết nối, mặc định là 5000 |
| -n | Số lượng bufers |
| -N | Số lượng luồng dữ liệu truyền |
| -R | Tốc độ truyền |
| -l | packet length |
| -T | thời gian, mặc định là 10 giây |
| -i | thời gian gửi báo cáo (giây) |


### Ví dụ

Sau khi cài nuttcp trên client và server, chạy lệnh sau trên server

	nuttup -S

Client:

	nuttcp <serverhost>

Câu lệnh này sử dụng phương thức test mặc định là cứ 10s lại gửi một gói tin tcp

	trangnth@intern-meditech:~$ nuttcp 192.168.60.134
	4207.6524 MB /  10.03 sec = 3519.6883 Mbps 53 %TX 90 %RX 0 retrans 0.39 msRTT

%TX và %RX là mức độ sử dụng CPU trên transmitter và receiver

Để đẩy window size lên cao hơn: thường sử dụng để test số lượng packet bị mất. Câu lệnh trên sẽ truyền trong 10 giây các gói tin udp với tốc độ 50 Mbps. Nó sẽ trả về 1 report mỗi giây:

	nuttcp -u -i -Ri50m <serverhost>

Tham khảo thêm một số trường hợp khác [ở đây](http://nuttcp.net/nuttcp/5.1.3/examples.txt)

### Tham khảo:

https://www.systutorials.com/docs/linux/man/8-nuttcp/

https://github.com/thaonguyenvan/meditech-thuctap/edit/master/ThaoNV/Tim%20hieu%20command/docs/nuttcp.md

http://nuttcp.net/nuttcp/5.1.3/examples.txt