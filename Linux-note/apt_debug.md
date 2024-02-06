# Note lại 1 số lỗi củ chuối đã gặp

## Cài gói nhưng bị lệch version giữa các gói dependency

history

```
  737  apt search qemu | grep rbd
  738  dpkg -l | grep compute
  739  apt policy libvirt-daemon-driver-storage-rbd
  740  vim /etc/apt/sources.list.d/cloudarchive-wallaby.list
  741  apt update 
  742  apt policy libvirt-daemon-driver-storage-rbd
  743  apt-get clean
  744  apt update 
  745  apt policy libvirt-daemon-driver-storage-rbd
  746  vim /etc/apt/sources.list
  747  apt policy libvirt-daemon-driver-storage-rbd
  748  dpkg -l | grep libvirt
  749  dpkg -l | grep qemu
```

* libvirt không connect được đến ceph (rpd protocol not found) Lệch version giữa các gói dependency

```
# check version của rbd
root@trangnth-controller:~# apt search qemu | grep rbd
root@trangnth-controller:~# apt policy libvirt-daemon-driver-storage-rbd

# bị lệch version vơi các gói dependency khác

root@trangnth-controller:~# dpkg -l | grep libvirt
ii  libsys-virt-perl                     5.0.0-1build1                                        amd64        Perl module providing an extension for the libvirt library
ii  libvirt-clients                      6.0.0-0ubuntu8.11                                    amd64        Programs for the libvirt library
ii  libvirt-daemon                       6.0.0-0ubuntu8.11                                    amd64        Virtualization daemon
ii  libvirt-daemon-driver-qemu           6.0.0-0ubuntu8.9                                     amd64        Virtualization daemon QEMU connection driver
ii  libvirt-daemon-driver-storage-rbd    6.0.0-0ubuntu8.15                                    amd64        Virtualization daemon RBD storage driver
ii  libvirt-daemon-system                6.0.0-0ubuntu8.11                                    amd64        Libvirt daemon configuration files
ii  libvirt-daemon-system-systemd        6.0.0-0ubuntu8.11                                    amd64        Libvirt daemon configuration files (systemd)
ii  libvirt0:amd64                       6.0.0-0ubuntu8.15                                    amd64        library for interfacing with different virtualization systems
ii  nova-compute-libvirt                 3:23.1.0-0ubuntu1~cloud0                             all          OpenStack Compute - compute node libvirt support
ii  python3-libvirt                      6.1.0-1    
```

* một máy khác vẫn cài đặt bình thường

```
root@trangnth-compute:~# dpkg -l | grep libvirt
ii  libsys-virt-perl                      5.0.0-1build1                                        amd64        Perl module providing an extension for the libvirt library
ii  libvirt-clients                       6.0.0-0ubuntu8.11                                    amd64        Programs for the libvirt library
ii  libvirt-daemon                        6.0.0-0ubuntu8.11                                    amd64        Virtualization daemon
ii  libvirt-daemon-driver-qemu            6.0.0-0ubuntu8.11                                    amd64        Virtualization daemon QEMU connection driver
ii  libvirt-daemon-driver-storage-rbd     6.0.0-0ubuntu8.11                                    amd64        Virtualization daemon RBD storage driver
ii  libvirt-daemon-system                 6.0.0-0ubuntu8.11                                    amd64        Libvirt daemon configuration files
ii  libvirt-daemon-system-systemd         6.0.0-0ubuntu8.11                                    amd64        Libvirt daemon configuration files (systemd)
ii  libvirt0:amd64                        6.0.0-0ubuntu8.11                                    amd64        library for interfacing with different virtualization systems
ii  nova-compute-libvirt                  3:23.0.0-0ubuntu1~cloud0                             all          OpenStack Compute - compute node libvirt support
ii  python3-libvirt                       6.1.0-1                                              amd64        libvirt Python 3 bindings
```

* chạy apt-update thấy đang trỏ khác repo giữa 2 server, đổi về cùng 1 repo

```sh
# /etc/apt/sources.list
deb http://vn.archive.ubuntu.com/ubuntu focal-security main restricted
# deb-src http://vn.archive.ubuntu.com/ubuntu focal-security main restricted
deb http://vn.archive.ubuntu.com/ubuntu focal-security universe
# deb-src http://vn.archive.ubuntu.com/ubuntu focal-security universe
deb http://vn.archive.ubuntu.com/ubuntu focal-security multiverse
# deb-src http://vn.archive.ubuntu.com/ubuntu focal-security multiverse
```

* Clean cache, thực  hiện chạy update và cài đặt lại tất cả các gói

```sh
apt-get clean -y
apt autoclean -y
apt update -y
apt install libvirt-clients libvirt-daemon libvirt-daemon-driver-qemu libvirt-daemon-driver-storage-rbd libvirt-daemon-system libvirt-daemon-system-systemd libvirt0 nova-compute-libvirt -y
```

* check lại verison

```
root@trangnth-controller:~# apt policy libvirt-daemon-driver-storage-rbd
libvirt-daemon-driver-storage-rbd:
  Installed: 6.0.0-0ubuntu8.15
  Candidate: 6.0.0-0ubuntu8.16
  Version table:
     6.0.0-0ubuntu8.16 500
        500 http://vn.archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages
        500 http://vn.archive.ubuntu.com/ubuntu focal-security/main amd64 Packages
 *** 6.0.0-0ubuntu8.15 100
        100 /var/lib/dpkg/status
     6.0.0-0ubuntu8 500
        500 http://vn.archive.ubuntu.com/ubuntu focal/main amd64 Packages
root@trangnth-controller:~# dpkg -l | grep libvirt
ii  libsys-virt-perl                     5.0.0-1build1                                        amd64        Perl module providing an extension for the libvirt library
ii  libvirt-clients                      6.0.0-0ubuntu8.15                                    amd64        Programs for the libvirt library
ii  libvirt-daemon                       6.0.0-0ubuntu8.15                                    amd64        Virtualization daemon
ii  libvirt-daemon-driver-qemu           6.0.0-0ubuntu8.15                                    amd64        Virtualization daemon QEMU connection driver
ii  libvirt-daemon-driver-storage-rbd    6.0.0-0ubuntu8.15                                    amd64        Virtualization daemon RBD storage driver
ii  libvirt-daemon-system                6.0.0-0ubuntu8.15                                    amd64        Libvirt daemon configuration files
ii  libvirt-daemon-system-systemd        6.0.0-0ubuntu8.15                                    amd64        Libvirt daemon configuration files (systemd)
ii  libvirt0:amd64                       6.0.0-0ubuntu8.15                                    amd64        library for interfacing with different virtualization systems
ii  nova-compute-libvirt                 3:23.1.0-0ubuntu1~cloud0                             all          OpenStack Compute - compute node libvirt support
ii  python3-libvirt                      6.1.0-1                                              amd64        libvirt Python 3 bindings
```

