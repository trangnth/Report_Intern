# Command Check System info

Một số các command để check các thông tin của hệ điều

* Command `cat /etc/*release` 

```sh
	ubuntu@ip-172-31-22-1:~$ cat /etc/*release
	DISTRIB_ID=Ubuntu
	DISTRIB_RELEASE=16.04
	DISTRIB_CODENAME=xenial
	DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
	NAME="Ubuntu"
	VERSION="16.04.3 LTS (Xenial Xerus)"
	ID=ubuntu
	ID_LIKE=debian
	PRETTY_NAME="Ubuntu 16.04.3 LTS"
	VERSION_ID="16.04"
	HOME_URL="http://www.ubuntu.com/"
	SUPPORT_URL="http://help.ubuntu.com/"
	BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
	VERSION_CODENAME=xenial
	UBUNTU_CODENAME=xenial
```

Lệnh này sẽ cho chúng ta thông tin về tên hệ điều hành, phiên bản và distro đang dùng và một số các thông tin trợ giúp khác.

* Command `uname -a` dùng cho cả Ubuntu với CentOS
	
```sh	
	ubuntu@ip-172-31-22-1:~$ uname -a
	Linux ip-172-31-22-1 4.4.0-1041-aws #50-Ubuntu SMP Wed Nov 15 22:18:17 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
```

Lệnh này show ra đầy đủ các thông tin của kernel như phiên bản kernel là `4.4.0-1041-aws`, 32bit hay 64bit

Có thể dùng các tùy chọn khác để show ra từng thông tin một

	-a, --all                print all information, in the following order, except omit -p and -i if unknown:
	-s, --kernel-name        print the kernel name
	-n, --nodename           print the network node hostname
	-r, --kernel-release     print the kernel release
	-v, --kernel-version     print the kernel version
	-m, --machine            print the machine hardware name
	-p, --processor          print the processor type (non-portable)
	-i, --hardware-platform  print the hardware platform (non-portable)
	-o, --operating-system   print the operating system
	    --help     display this help and exit
	    --version  output version information and exit

* Command `cat /proc/version`: cũng kiểm tra thông tin kernel

```sh
	ubuntu@ip-172-31-22-1:~$ cat /proc/version
	Linux version 4.4.0-1041-aws (buildd@lgw01-amd64-025) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5) ) #50-Ubuntu SMP Wed Nov 15 22:18:17 UTC 2017
```

* Một số các các thông tin khác chưa trong `/proc`, các lệnh cơ bản
	* Command `/proc/meminfo`:  Ram info
	* `Cmd`

	/proc/cpuinfo: hiển thị thông tin CPU
	/proc/mounts: xem trạng thái tất cả các file system đã mount
	/proc/partitions: thông tin các phân vùng

* Command `lsb_release -a` kiểm tra phiên bản hệ điều hành distro của nó, không dùng được trên CentOS

	ubuntu@ip-172-31-22-1:~$ lsb_release -a
	No LSB modules are available.
	Distributor ID:	Ubuntu
	Description:	Ubuntu 16.04.3 LTS
	Release:	16.04
	Codename:	xenial

* Command `sudo lspci` liệt kê các thiết bị PCI trong máy và Command `sudo lsusb` liệt kê tất cả các thiết bị usb
	
	ubuntu@ip-172-31-22-1:~$ sudo lspci
	00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
	00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
	00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
	00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 01)
	00:02.0 VGA compatible controller: Cirrus Logic GD 5446
	00:03.0 Unassigned class [ff80]: XenSource, Inc. Xen Platform Device (rev 01)

* Command `lscpu` hiển thị thông tin về cpu

* Command `free -m` xem thông tin RAM và SWAP

* Command `fdisk -l` xem các thông tin phân vùng ổ cứng

* Command `df -h` hiển thị các thông về không gian sử dụng đĩa

* Command `du -sh` xem dung lượng của thư mục hiện hành, `du` để xem dung lượng của tất cả các thư mục con bên trong










