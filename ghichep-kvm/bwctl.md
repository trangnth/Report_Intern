# BWCTL (Bandwidth Test Controller)

## 1. Tổng quan

BWCTL là một công cụ dòng lệnh sử dụng một loạt các công cụ đo lường network như Iperf, Iperf3, Nuttcp, Ping, Traceroute, Tracepath, và OWAMP để đo băng thông TCP tối đa với một loạt các tùy chọn điều chỉnh khác nhau như sự trễ, tỉ lệ mất gói tin,... Mặc định, bwctl sẽ dùng iperf.


## 2. Cài đặt và sử dụng

### 2.1 Cài đặt trên Ubuntu 16.04

#### Server

Cài đặt bwctl-server

	sudo apt-get update
	sudo apt-get install bwctl-server -y

#### Client

	sudo apt-get update
	sudo apt-get install bwctl-client -y

Cài đặt ntp và cấu hình để cả server và client đều trỏ về một ntp server

	apt-get install ntp -y

Chỉnh sửa file `/etc/ntp.conf` 

	server vn.pool.ntp.org iburst

Khởi động lại dịch vụ:

	systemctl restart ntp.service 

Kiểm tra lại xem được chưa

	ntpq -p



### 2.2 Các option phổ biến

Dạng câu lệnh bwctl

	bwctl [options] -c recvhost -s sendhost 
	bwctl [options] -c recvhost 
	bwctl [options] -s sendhost



| Options | Descriptions |
|---------|--------------|
| -4, --ipv4 | Chỉ dùng ipv4 |
| -6, --ipv6 | Chỉ dùng ipv6 |
| -c, --receiver | Chỉ định host chạy Iperf, Iperf3 or Nuttcp server |
| -s, --sender | Chỉ định host chạy Iperf, Iperf3 or Nuttcp client |
| -T, --tool | Chỉ định tool sử dụng ( iperf, iperf3, nuttcp) |
| -b, --bandwidth  | Giới hạn send rate bandwidth với UDP (bits/sec), mặc định là 1Mb |
| -i, --interval| Báo cáo interval (sec), mặc định là unset|
| -l, --buffer_length | Độ dài của read/write buffers (bytes). Mặc định 8 KB TCP, 1470 bytes UDP |
| -S, --TOS | Thiết lập TOS byte trong packet, mặc định là không set|
| -t,--test_duration | Thời gian cho bài test, mặc định là 10 giây |
| -u, --udp | Dùng UDP test, vì mặc định là dùng TCP |
| -h, --help | Show help message |
| -p, --print | In kết quả ra file |
| -V, --version | Phiên bản |
| -P | Số luồng kết nối tới server |
| -w | kích thước gói tin |
| --tester_port | port để test, mặc định được specific bởi công cụ sử dụng |
| -d, --dir | Chỉ định thư mục chứa file kết quả nếu option `-p` được set |

#### Environment variables


|bwctl Environment Variable	|use	|default|
|--|--|--|
|BWCTLRC	|Config file|	~/.bwctlrc|
|BWCTL_DEBUG_TIMEOFFSET	|Offset|	0.0(seconds)|

#### Ví dụ một số câu lệnh

Trên server chạy lệnh sau:

	bwctld -c <path-to-folder-config>

Thường các file config sẽ ở trong `/etc/bwctl/`

	bwctld -c /etc/bwctl/

Chạy các lệnh test trên client như sau:

	bwctl -c receive_host

Sử dụng client như người gửi, chạy test iperf mỗi 10s

	bwctl -x -c somehost.example.com

Giống lệnh trên, nhưng trả về kết quả cho người gửi

```sh
root@intern-meditech:~# bwctl -x -c 192.168.60.134
bwctl: Using tool: iperf
bwctl: 16 seconds until test results available

RECEIVER START
------------------------------------------------------------
Server listening on TCP port 5586
Binding to local address 192.168.60.134
TCP window size: 87380 Byte (default)
------------------------------------------------------------
[ 15] local 192.168.60.134 port 5586 connected with 192.168.60.129 port 5586
[ ID] Interval       Transfer     Bandwidth
[ 15]  0.0-10.0 sec  4417388544 Bytes  3530167093 bits/sec
[ 15] MSS size 1448 bytes (MTU 1500 bytes, ethernet)

RECEIVER END

SENDER START
------------------------------------------------------------
Client connecting to 192.168.60.134, TCP port 5586
Binding to local address 192.168.60.129
TCP window size: 348160 Byte (default)
------------------------------------------------------------
[  6] local 192.168.60.129 port 5586 connected with 192.168.60.134 port 5586
[ ID] Interval       Transfer     Bandwidth
[  6]  0.0-10.0 sec  4417388544 Bytes  3533333135 bits/sec
[  6] MSS size 1448 bytes (MTU 1500 bytes, ethernet)

SENDER END
``` 



## Tham khảo

http://code.tools/man/1/bwctl/

http://software.internet2.edu/bwctl/

https://github.com/thaonguyenvan/meditech-thuctap/edit/master/ThaoNV/Tim%20hieu%20command/docs/bwctl.md