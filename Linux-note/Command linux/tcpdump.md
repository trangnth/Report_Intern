# TCPDUMP

## 1. Khái niệm tcpdump
**tcpdump** là một công cụ command-line để chặn bắt hoặc phân tích gói tin mạnh mẽ và được sử dụng rộng rãi. Tcpdump sẽ caoture hoặc filter các gói TCP/IP nhận được qua mạng trên các interface cụ thể.

Nó có sẵn hầu hết trên các hệ điều hành linux/unix.

Tcpdump cũng cung cấp cho chúng ta các tùy chọn để có thể lưu ra file dạng `pcap` và có thể đọc được bằng công cụ đồ họa Wireshark.

## 2. Cài đặt và sử dụng
### 2.1 Cài đặt
Trên CentOS
	
	yum install tcpdump -y

Trên Ubuntu

	sudo apt-get install tcpdump -y

### 2.2 Cách sử dụng

Định dạng chung:

	tcpdump [ -AbdDefhHIJKlLnNOpqStuUvxX# ] [ -B buffer_size ] 

Trong đó:

```sh
[ -c count ] [ -C file_size ] 
[ -E spi@ipaddr algo:secret,... ] 
[ -F file ] [ -G rotate_seconds ] [ -i interface ] 
[ --immediate-mode ] [ -j tstamp_type ] [ -m module ] 
[ -M secret ] [ --number ] [ --print ] [ -Q in|out|inout ] 
[ -r file ] [ -s snaplen ] [ -T type ] [ --version ] 
[ -V file ] [ -w file ] [ -W filecount ] [ -y datalinktype ] 
[ -z postrotate-command ] [ -Z user ] 
[ --time-stamp-precision=tstamp_precision ] 
[ expression ] 	
```

Tcpdump sẽ in ra một mô tả về nội dung của các gói trên một giao diện mạng phù hợp với biểu thức boolean; mốc thời gian sẽ bắt đầu từ 12h đêm.

Với cờ `-w`, tcpdump sẽ lưu dữ liệu gói vào một tệp để phân tích sau. Với `/` hoặc với cờ `-r` cho phép đọc các gói từ tệp có sẵn thay vì đọc từ các interface. Với cờ `-V` cho phép đọc một danh sách các file đã lưu. Trong mọi trường hợp, chỉ các gói phù hợp với biểu thức mới được xử lý bởi tcpdump.

Khi tcpdump chạy xong, nó sẽ báo cáo các thông số sau:

* Số gói tin *"captured"*: là số gói tin mà tcpdump nhận và xử lý.
* Số các gói tin *"received by filter"*: là số các gói tin bị lọc (với một số hệ điều hành nó có thể đếm cả các gói tin bị lọc mà chưa qua xử lý của tcpdump, một số khác thì có thể không).
* Số gói tin *"dropped by kernel"*: là các gói tin bị loại bỏ do thiếu dung lượng bộ nhớ đệm, điều này còn dựa vào cơ chế capture gói tin của hệ điều hành mà nó đang chạy có cho phép báo cáo các thông tin đó hay không, nếu không nó sẽ trả về 0.

## 3. Các command thông dụng

### Display Available Interfaces

Liệt kê ra các giao diện có sẵn trên hệ thống chạy lệnh sau:

	tcpdump -D

### Capture Packets from Specific Interface

Để bắt các gói tin trên card mạng eth0 sử dụng:

	tcpdump -i eth0

Nếu muốn dừng bấm `ctrl + c`, sau khi dừng tcpdump sẽ báo cáo lại 3 thông số: `Packet capture`, `Packet received by filter`, `Packet dropped by kernel`

#### Định dạng chung của một dòng trong tcpdump là: 

	time-stamp src > dst:  flags  data-seqno  ack  window urgent options


|Tên trường | Mô tả |
|--- | --- |
|Time-stamp | hiển thị thời gian gói tin được capture. |
|Src và dst | hiển thị địa IP của người gửi và người nhận. |
|Cờ Flag| S(SYN):  Được sử dụng trong quá trình bắt tay của giao thức TCP.</br>.(ACK):  Được sử dụng để thông báo cho bên gửi biết là gói tin đã nhận được dữ liệu thành công.</br>F(FIN): Được sử dụng để đóng kết nối TCP.</br>P(PUSH): Thường được đặt ở cuối để đánh dấu việc truyền dữ liệu.</br>R(RST): Được sử dụng khi muốn thiết lập lại đường truyền. |
|Data-sqeno | Số sequence number của gói dữ liệu hiện tại. |
|ACK | Mô tả số sequence number tiếp theo của gói tin do bên gửi truyền (số sequence number mong muốn nhận được). |
|Window | Vùng nhớ đệm có sẵn theo hướng khác trên kết nối này. |
|Urgent | Cho biết có dữ liệu khẩn cấp trong gói tin. |

### Capture Only N Number of Packets
Mặc định tcpdump sẽ bắt liên tiếp các gói tin, sử dụng tùy chọn `-c` để bắt số gói tin mong muốn.

	tcpdump -c 5 -i eth0

### Print Captured Packets in ASCII

	tcpdump -A -i eth0

###  Capture and Save Packets in a File

tcpdump sẽ lưu file với định dạng `.pcap` với tùy chọn `-w`

	tcpdump -w 0001.pcap -i eth0

### Read Captured Packets File

	tcpdump -r 0001.pcap

### Capture IP address Packets

Để bắt các gói tin đặc biệt trên các interface, chạy lệnh với option `-n`

	tcpdump -n -i eth0

### Capture only TCP Packets

	tcpdump -i eth0 tcp

### Capture Packet from Specific Port

	tcpdump -i eth0 port 22

### Capture Packets from source IP or destination IP

Nếu muốn bắt các gói tin có nguôn là 192.168.0.2 hoặc đích là 50.116.66.139 thì sử dụng câu lệnh sau:

	tcpdump -i eth0 src 192.168.0.2
	tcpdump -i eth0 dst 50.116.66.139

### Get Packet Contents with Hex Output

```sh
tcpdump -c 1 -X icmp
```

### Show Traffic Related to a Specific Port

```sh
tcpdump port 3389 
tcpdump src port 1025
```

Show Traffic of One Protocol

```sh
tcpdump icmp
```

Show only IP6 Traffic

```sh
tcpdump ip6
```

Find Traffic Using Port Ranges

```sh
tcpdump portrange 21-23
```

Find Traffic Based on Packet Size

```sh
tcpdump less 32 
tcpdump greater 64 
tcpdump <= 128
```

## Kết hợp sử dụng giữa các option với nhau

* **AND**: `and` hoặc `&&`
* **OR**: `or` hoặc `||`
* **EXCEPT**: `not` hoặc `!`

Ví dụ:

* From specific IP and destined for a specific Port: Tìm tất cả các trafic từ 10.5.2.3 đi tới bất kỳ host nào trên port 3389

```sh
tcpdump -nnvvS src 10.5.2.3 and dst port 3389
```



### Tham Khảo

[1] https://www.tcpdump.org/tcpdump_man.html

[2] https://www.tecmint.com/12-tcpdump-commands-a-network-sniffer-tool/

[3] https://github.com/hoangdh/tcpdump

[4] https://danielmiessler.com/study/tcpdump/#host-ip