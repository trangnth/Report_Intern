## Ghi chú một vài câu lệnh trong qua trình tìm hiểu

Trong `vim` nếu muốn thêm `#` để comment các dòng từ dòng 1 tới dòng 10 thì dùng lệnh sau (trong chế độ normal của vi/vim):

	:1,10s/^/#

Hiển thị một file mà trừ các dòng comment hoặc dòng trắng:
```sh
cat /etc/libvirt/libvirtd.conf | egrep -v "^$|^#"

# hoặc để thực hiện bỏ toàn bộ các dòng comment, kể cả các dòng comment thụt vào một đoạn (nếu tab khong phải là 4 space thì sẽ ko lọc được)
cat /etc/httpd/conf/httpd.conf | egrep -v "^#|^$|^ *#|^[\t]#"

# Hoặc sử dụng cách sau để convert tab thành ^I sau đó loại bỏ toàn bộ dòng bắt đầu với ^I# (nhưng các dòng nào có dấu tab giữa dòng sẽ bị hiển thi ra)
cat -T /etc/httpd/conf/httpd.conf | egrep -v "^#|^$|^ *#|^\^I#"

# Hoặc sử dụng command như sau để convert toàn bộ spcae thành space rồi lọc
expand /etc/httpd/conf/httpd.conf | egrep -v "^#|^$|^ *#"
```

Sử dụng command expand để convert toàn bộ tab thành space với số lượng chỉ định

```sh
expand -t N tab_file

# hoặc 

expand -t2 tab_file > space_file

# Ví dụ chuyern tất cả các dấu tab (hiện đang bằng 4 space) thành 2 ký tự space
[root@controller1 ~(openstack)]# expand test.txt
asdasd
aad
        qasd
aas
[root@controller1 ~(openstack)]# expand -t 2 test.txt
asdasd
aad
  qasd
aas
```

### Một số các command cơ bản hữu ích 

* Thực hiện command ngay trước đó:

```sh
!!
```



* Hiển thị routing table

```sh
[root@trang-40-71 ~(openstack)]# netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.40.1    0.0.0.0         UG        0 0          0 eth0
169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth2
169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 br-provider
192.168.40.0    0.0.0.0         255.255.255.0   U         0 0          0 eth0
192.168.50.0    0.0.0.0         255.255.255.0   U         0 0          0 eth1
192.168.68.0    0.0.0.0         255.255.255.0   U         0 0          0 br-provider

[root@trang-40-71 ~(openstack)]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    100    0        0 eth0
link-local      0.0.0.0         255.255.0.0     U     1004   0        0 eth2
link-local      0.0.0.0         255.255.0.0     U     1016   0        0 br-provider
192.168.40.0    0.0.0.0         255.255.255.0   U     100    0        0 eth0
192.168.50.0    0.0.0.0         255.255.255.0   U     101    0        0 eth1
192.168.68.0    0.0.0.0         255.255.255.0   U     0      0        0 br-provider
```

* In giá trị của các biến môi trường

```sh
[root@trang-40-71 ~(openstack)]# printenv
XDG_SESSION_ID=151757
HOSTNAME=trang-40-71
TERM=xterm
SHELL=/bin/bash
HISTSIZE=1000
SSH_CLIENT=192.168.100.214 52491 22
SSH_TTY=/dev/pts/0
OS_USER_DOMAIN_NAME=default
USER=root
OS_PROJECT_NAME=admin
MAIL=/var/spool/mail/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
OS_IDENTITY_API_VERSION=3
PWD=/root
OS_PASSWORD=trang1234
LANG=en_US.UTF-8
OS_AUTH_TYPE=password
PS1=[\u@\h \W(openstack)]\$
OS_AUTH_URL=http://controller:5000/v3
HISTCONTROL=ignoredups
OS_USERNAME=admin
SHLVL=1
HOME=/root
LOGNAME=root
SSH_CONNECTION=192.168.100.214 52491 192.168.40.71 22
...
```

* Liệt kê các process hiện tại đang chạy bởi user này

```sh
ps -Af
```
* Khởi động lại máy

```sh
shutdown -r now
```

* Hiển thị uid và gid 

```sh
[root@trang-40-71 ~(openstack)]# id
uid=0(root) gid=0(root) groups=0(root)
```

* Một số các command kiểm tra command và user login: `whatis`, `whereis`, `which`, `who`, `whoami`

* CPU info 

```sh
[root@trang-40-71 ~(openstack)]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)
stepping        : 9
microcode       : 0x1
cpu MHz         : 2099.998
cache size      : 4096 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
...
```

* Memory usage 

```sh
[root@trang-40-71 ~(openstack)]# cat /proc/meminfo
MemTotal:        5944896 kB
MemFree:          173496 kB
MemAvailable:     256968 kB
Buffers:          150572 kB
Cached:           409880 kB
SwapCached:        69420 kB
Active:          4322676 kB
...
```

* Networking devices

```sh
[root@trang-40-71 ~(openstack)]# cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
qr-fe9a0746-77:       0       0    0   36    0     0          0         0        0       0    0    0    0     0       0          0
br-provider: 283064510 9294826    0   60    0     0          0         0     1486      27    0    0    0     0       0          0
ovs-system:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
br-int:       0       0    0 9294868    0     0          0         0        0       0    0    0    0     0       0          0
br-tun:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
qr-269ec8de-2f:       0       0    0   36    0     0          0         0        0       0    0    0    0     0       0          0
  eth0: 2187226015 8575732    0    0    0     0          0         0 12719714310 7771852    0    0    0     0       0          0
  eth1: 24269664  379007    0   90    0     0          0         0    12531      87    0    0    0     0       0          0
  eth2: 437473705 9673966    0    0    0     0          0         0   131445     791    0    0    0     0       0          0
    lo: 60506269709 157072298    0    0    0     0          0         0 60506269709 157072298    0    0    0     0       0          0
qg-7b3374e1-dc:       0       0    0   36    0     0          0         0        0       0    0    0    0     0       0          0
```

* Kernel version 


```sh
[root@trang-40-71 ~(openstack)]# cat /proc/version
Linux version 3.10.0-957.10.1.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 SMP Mon Mar 18 15:06:45 UTC 2019
```

* Hiện thị kernel modules hiện tại đang được load

```sh
[root@trang-40-71 ~(openstack)]# lsmod
Module                  Size  Used by
nfnetlink_queue        18197  0
nfnetlink_log          17892  0
nfnetlink              14490  2 nfnetlink_log,nfnetlink_queue
bluetooth             548688  0
rfkill                 22391  1 bluetooth
xt_REDIRECT            12757  1
nf_nat_redirect        12771  1 xt_REDIRECT
```

* Hiển thị thông tin hệ thống

```sh
dmidecode
```

* Hiển thị thông tin về BIOS

```sh
[root@trang-40-71 ~(openstack)]# dmidecode -t 0
# dmidecode 3.1
Getting SMBIOS data from sysfs.
SMBIOS 2.4 present.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Seabios
        Version: 0.5.1
        Release Date: 01/01/2011
        Address: 0xE8000
        Runtime Size: 96 kB
        ROM Size: 64 kB
        Characteristics:
                BIOS characteristics not supported
                Targeted content distribution is supported
        BIOS Revision: 1.0
```



