## Linux Network Namespaces

Thông thường, một bản cài đặt Linux sẽ chia sẻ chung tập hợp các network interfaces và các bản ghi trên bảng định tuyến. Ta có thể chỉnh sửa bảng định tuyến sử dụng các chính sách định tuyến, tuy nhiên về căn bản thì điều đó không thay đổi thực tế là các network interfaces và các bảng định tuyến vẫn chia sẻ chung khi xét trên toàn bộ hệ điều hành. Linux network namespaces được đưa ra để giải quyết vấn đề đó. Với linux namespaces, ta có thể có các máy ảo tách biệt nhau về network interfaces cũng như bảng định tuyến khi mà các máy ảo này vận hành trên các namespaces khác nhau. Mỗi network namespaces có bản định tuyến riêng, các thiết lập iptables riêng cung cấp cơ chế NAT và lọc đối với các máy ảo thuộc namespace đó. Linux network namespaces cũng cung cấp thêm khả năng để chạy các tiến trình riêng biệt trong nội bộ mỗi namespace.

## Cấu trúc cơ bản Namspace

Tạo một network namesoace

	$ ip netns add Bo
	$ ip netns list
	Bo
	$ ll /var/run/netns/
	total 0
	drwxr-xr-x  2 root root  60 Jun 21 21:05 ./
	drwxr-xr-x 24 root root 720 Jun 21 21:05 ../
	-r--r--r--  1 root root   0 Jun 21 21:05 Bo

Mỗi một network namespaces sẽ có một địa chỉ loopback, bảng định tuyến và iptables riêng.

	$ ip netns exec Bo ip addr list
	1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1
	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

Bật nó lên

	ip netns exec Bo ip link set dev lo up
	ip netns exec Bo ifconfig

Network namespace còn cung cấp khả năng chạy các tiến trình trên nó. Ví dụ dưới đây chạy một chương trình bash trên namespace Bo

	ip netns exec Bo bash

Xóa một namespace

	ip netns delete Bo

### Gán cổng cho network namespaces

Để kết nối network namespace với mạng bên ngoài cần gán các virtual interface vào "default" hoặc "global" namespace, nơi mà card mạng thật được gán vào. Để làm được điều này, trước tiên ta cần tạo ra 2 virtual interfaces là veha và vehb

	ip link add vetha type veth peer name vethb

Gán vehb vào namespaces Bo

	ip link set vethb netns Bo
	ip netns exec Bo ip link set dev vethb up
	ip link set dev vetha up
	ip netns exec Bo ifconfig
	ifconfig

Cấu hình virtual interface nằm tại namespace global và trong namespace Bo

	ip addr add 192.168.100.1/24 dev vetha
	route
	ip netns exec Blue ip addr add 192.168.100.2/24 dev vethb
	ip netns exec Blue route

Giờ hãy ping thử giữa hai namespace

	ping 192.168.100.2
	ip netns exec Bo ping 192.168.100.1

Ta thấy đều ping được, nhưng chúng được định tuyến hoàn toàn khác nhau, giờ ping thử ra máy mạng khác ta sẽ thấy:

```sh
root@ubuntu:~# ip netns exec Bo ping 192.168.60.1
connect: Network is unreachable
root@ubuntu:~# ping 192.168.60.1
PING 192.168.60.1 (192.168.60.1) 56(84) bytes of data.
64 bytes from 192.168.60.1: icmp_seq=1 ttl=128 time=0.322 ms
64 bytes from 192.168.60.1: icmp_seq=2 ttl=128 time=0.298 ms
```
