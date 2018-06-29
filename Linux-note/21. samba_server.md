## Samba server and Windows file sharing

Samba hoàn toàn là mã nguồn mở chạy trên nền giao thức SMB/CIFS. Nó cho phép hệ thống Microsoft Windows®, Linux, UNIX và các hệ thống khác kết nối với nhau. Samba cho phép Linux/unix server xuất hiện như windows server với các windows clients để chia sẻ file và máy in với các máy chạy Windows.

Với samba, admin có thể: 

1. Phục vụ cây thư mục và dịch vụ in cho các máy clients chạy hđh Linux, UNIX, và Windows.
2. Hỗ trợ duyệt mạng có hoặc không có NetBIOS
3. Xác thực đăng nhập domain Windows
4. Cung cấp giải pháp WINS name server.

Samba là sự kết hợp của smb, nmb, và winbind services.

`smbd` server cung cấp dịch vụ in và chia sẻ dữ liệu cho các máy Windows clients. Nó có trách nhiệm xác thực người dùng, khóa tài nguyên và chia sẻ dữ liệu thông qua giao thức SMB. Port mặc định mà server dùng cho SMB là các cổng TCP 139 và 445.

`nmbd` server có thể hiểu và trả lời các requests từ SMB. Port mặc định của dịch vụ này là UDP 137.

`winbindd` sẽ giải quyết thông tin người dùng tới từ những server chạy Windows. Điều này sẽ làm cho thông tin của các Windows clients có thể được "hiểu" bởi các máy chủ chạy Linux và UNIX. Cả winbindd và smbd đều đi kèm trong các bản phân phối của Samba. Tuy vậy chúng được kiểm soát riêng biệt với nhau.

## Cài đặt

### Requirements

Server:

	Ubuntu 16.04
	ip: 192.168.60.130

Client:

	Windows 10

### Installation

Cài đặt samba trên ubuntu 16.04 và backup file config lại

	sudo apt-get install samba
	sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bk

Cấu hình file `/etc/samba/smb.conf`, thêm vào cuối file như sau:

```sh
#======================= Share Definitions =======================
[share1]
	comment = Private Documents
	path = /samba/admin/data # Đường dẫn tới file share 
	valid users = admin  # user hợp lệ 
	# valid users = @group_name
	invalid users = user2 user3 # user không hợp lệ 
	guest ok = no # guest không được truy cập 
	writable = yes # có quyền ghi, mặc định là readonly
	browsable = yes # hiển thị thư mục share 

[share2]
	comment = Public Documents
	path = /samba/user2/data
	valid users = user2 admin
	guest ok = no
	writable = yes
	browsable = yes

[share3]
	comment = Public Documents
	path = /samba/user3/data
	valid users = user3 admin
	guest ok = no
	writable = yes
	browsable = yes

[share4]
	comment = Public Documents
	path = /samba/share4
	guest ok = yes
	writable = yes
	browsable = yes
```

`share1` chỉ được truy cập bởi `admin`, `share2` được truy cập bởi `admin` và `user2`, `share3` thì được truy cập bởi `admin` và `user3`, `share4` được truy cập bởi tất cả mọi người.

Kiểm tra cấu hình sử dụng lệnh:

	testparm

Tạo 4 thư mục như trên trên và tạo 3 user admin, user1, user2. 

```sh
mkdir -p /samba/admin/data
mkdir -p /samba/user2/data	
mkdir -p /samba/user3/data
mkdir -p /samba/share4
useradd admin
useradd user2
useradd user3 
```

Sau đó tạo password samba cho mỗi user bằng lệnh:

	smbpasswd -a <username>

Để thư mục `/samba/share4` cho phép mọi người đều truy cập được thì phải đổi user và group sở hữu là nobody

	chown nobody:nogroup /samba/share4/

Giờ hãy thử vào một máy windows rồi gõ `\\192.168.60.130` và nhập username pass của bạn cho từng thư mục muốn vào.

<img src="img/7.png">

Nếu sử dụng nhiều và thuận tiện hơn, bạn có thể map nó như một ổ của windows để sử dụng.
