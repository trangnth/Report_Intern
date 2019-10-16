# Tìm hiểu và cài đặt apt-cacher-ng

[1. Tổng quan apt-cacher-ng](#overview)

[2. Cài đặt và cấu hình](#config)


<a name="overview"></a>
## 1. Tổng quan apt-cacher-ng

Apt-cacher-ng là một proxy server dùng để cache các gói tin được download từ internet trên server và các client khác có thể sử dụng cho lần sau. Các client khi cài đặt lại, thay vì phải ra internet để download package về thì có thể lên con apt-cacher-ng (được đặt tại local) này để tải. 

Có thể sử dụng cho các client là Ubuntu hoặc Centos.

Ưu điểm:

* Tiết kiệm thời gian
* Tiết kiệm bằng thông
* Giữ lại và cài đặt các phiên bản mong muốn


<a name="config"></a>
## 2. Cài đặt và cấu hình

### Trên server:

Cài đặt các gói cần thiết:

	apt-get -y install apache2
	apt-get install apt-cacher-ng

Sửa hoặc thêm một số dòng sau trong file config `vi /etc/apt-cacher-ng/acng.conf`

```sh
Port:3142
BindAddress: 0.0.0.0
Remap-centos: file:centos_mirrors /centos
VerboseLog: 1
PidFile: /var/run/apt-cacher-ng/pid
DnsCacheSeconds: 2000
PassThroughPattern: .*
VfilePatternEx: ^/\?release=[0-9]+&arch=
VfilePatternEx: ^(/\?release=[0-9]+&arch=.*|.*/RPM-GPG-KEY-examplevendor)$
```

Tạo mirror list bằng lệnh:

	curl https://www.centos.org/download/full-mirrorlist.csv | sed 's/^.*"http:/http:/' | sed 's/".*$//' | grep ^http >/etc/apt-cacher-ng/centos_mirrors

Khởi động lại dịch vụ:

	service apt-cacher-ng restart

Sau đó bạn có thể truy cập vào trang quản trị với địa chỉ: 

	ip-server:3142

### Trên Client

Với client là Ubuntu:

	echo 'Acquire::http { Proxy "http://x.x.x.x:3142"; };' > /etc/apt/apt.conf.d/01proxy

Với client là CentOS:

	echo "proxy=http://x.x.x.x:3142" >> /etc/yum.conf



